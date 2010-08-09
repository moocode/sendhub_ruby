module Sendhub
  class Client
    private
      def _get(path)
        http(Net::HTTP::Get, path)
      end

      def _post(path, body = nil, options={})
        http(Net::HTTP::Post, path, body, options)
      end
      
      def securely_hash_data(data)
        Digest::SHA1.hexdigest("--#{@api_key}-#{@secret_key}-#{data}--")
      end
      
      def http(http_method, path, body = nil, options={})
        connection = Net::HTTP.new(@uri.host, @uri.port)
        
        options.merge!(:api_key => @api_key)
        options.merge!(:unique => Time.now.utc.to_i)
        options.merge!(:secret => securely_hash_data(options[:unique]))
        
        puts "Path: #{path}"
        
        #if ssl?
          #connection.use_ssl = true
          #connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
          #connection.ca_file = Configuration.ca_file
          #connection.verify_callback = proc { |preverify_ok, ssl_context| verify_ssl_certificate(preverify_ok, ssl_context) }
        #end
        connection.start do |http|
          request = http_method.new("/v1#{path}")
          request["Accept"] = "application/xml"
          request["User-Agent"] = 'SendhubRubyClient/'+Sendhub::Client::VERSION
          request["Accept-Encoding"] = "gzip"
          request["X-ApiVersion"] = Sendhub::Client::VERSION
          request.basic_auth @api_key, @secret_key
          if body
            request["Content-Type"] = "application/xml"
            request.body = body
          end
          if http_method.inspect == 'Net::HTTP::Post' and !options.empty?
            request.set_form_data(options)
          end
          response = http.request(request)
          return JSON.parse(response.body)
        end
        
      end
      
      #def verify_ssl_certificate(preverify_ok, ssl_context)
      #  if preverify_ok != true || ssl_context.error != 0
      #    err_msg = "SSL Verification failed -- Preverify: #{preverify_ok}, Error: #{ssl_context.error_string} (#{ssl_context.error})"
      #    Configuration.logger.error err_msg
      #    raise err_msg
      #  end
      #  true
      #end
  end
end