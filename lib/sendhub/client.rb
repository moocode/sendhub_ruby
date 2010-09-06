module Sendhub
  class Client
  
    VERSION = '0.1.8'
    
    def initialize(config=nil)
      config[:host] ||= 'api.sendhub.net'
      @uri = URI.parse('http://'+config[:host]+'/')
      
      @api_key = config[:api_key]
      @secret_key = config[:secret_key]
      
      puts "SendhubRubyClient: #{@uri}, #{@api_key}"
    end
    
    def send_email(options={})
      res = _post '/emails', nil, options
      #res.merge!('redirect_url' => @uri.to_s+"merchants/#{@merchant_id}/transactions/#{res['id']}")
      #res.merge!('secret_token' => securely_hash_data("#{res['id']}-#{res['amount']}"))
      Sendhub::Response.new(res)
    end
    
    def get(options={})
      res = _get('/email/' + options[:email_id])
      Sendhub::Response.new(res)
    end
      
  end
end
