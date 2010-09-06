module SendhubMethods
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    @sendhub_settings = {}
    attr_accessor :sendhub_settings
  end

  def perform_delivery_sendhub(message)
    client = Sendhub::Client.new(
      :api_key => ActionMailer::Base.sendhub_settings[:api_key],
      :secret_key => ActionMailer::Base.sendhub_settings[:secret_key]
    )
    res = client.send_email(
      :from => message.from,
      :to => message.to,
      :subject => message.subject,
      :body => message.body,
      :content_type => message.content_type
    )
  end

end

class ActionMailer::Base
  include SendhubMethods
end
