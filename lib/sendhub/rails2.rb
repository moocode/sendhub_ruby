module SendhubMethods
  def perform_delivery_sendhub(message)
    client = Sendhub::Client.new(
      :api_key => @@sendhub_settings[:api_key],
      :secret_key => @@sendhub_settings[:secret_key]
    )
    res = client.send_email(
      :from => message.from,
      :to => message.to,
      :subject => message.subject,
      :body => message.body,
      :content_type => message.content_type
    )
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def sendhub_settings=(options)
      @@sendhub_settings = options
    end
  end

end

class ActionMailer::Base
  include SendhubMethods
end
