module Sendhub
  class Rails
    def initialize(options)
      @client = Sendhub::Client.new(
        :host => options[:host],
        :protocol => options[:protocol],
        :api_key => options[:api_key],
        :secret_key => options[:secret_key],
        :notification_url => options[:notification_url]
      )
    end

    def deliver!(message)
      body = message.body
      body = collect_parts(message) if message.multipart?
      headers = collect_sendhub_headers(message)

      res = @client.send_email(
        :from => message.from,
        :to => message.to,
        :reply_to => message.reply_to,
        :subject => message.subject,
        :body => body,
        :content_type => message.content_type,
        :content_transfer_encoding => message.content_transfer_encoding,
        :headers => headers
      )

      puts res.inspect
    end

    def collect_parts(message)
      message.parts.inject("\n\n\n") {|x, part| x << "--#{message.boundary}\n"; x << "#{part.to_s}\n\n"}
    end

    def collect_sendhub_headers(message)
      message.header.fields.find_all{|x| x.name =~ /X-SendHub/}.collect{|x| {x.name => x.value}}
    end
  end
end

ActionMailer::Base.add_delivery_method :sendhub, Sendhub::Rails