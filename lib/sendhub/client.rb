module Sendhub
  class Client
  
    VERSION = '0.1.12'
    
    def initialize(config=nil)
      config[:host] ||= 'api.sendhub.net'
      config[:protocol] ||= 'https'
      @uri = URI.parse(config[:protocol]+'://'+config[:host]+'/')
      
      @api_key = config[:api_key]
      @secret_key = config[:secret_key]
      
      puts "SendhubRubyClient: #{@uri}, #{@api_key}"
    end
    
    def send_email(options={})
      res = _post '/emails', nil, options
      Sendhub::Response.new(res)
    end
    
    def get_email(options={})
      email_id = options.delete(:id)
      res = _get('/emails/' + email_id, options)
      Sendhub::Response.new(res)
    end
      
  end
end
