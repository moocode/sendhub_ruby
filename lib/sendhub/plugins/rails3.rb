module Sendhub
  class Rails
    def initialize(options)
      @client = Sendhub::Client.new(
        :api_key => options[:api_key],
        :secret_key => options[:secret_key]
      )
    end

    def deliver!(message)
      
      res = @client.send_email(
        :from => message.from,
        :to => message.to,
        :subject => message.subject,
        :body => message.body,
        :content_type => message.content_type
      )
      
      puts res.inspect
    end
  end
end

ActionMailer::Base.add_delivery_method :sendhub, Sendhub::Rails