require 'action_mailer'

module SendhubMethods
  def perform_delivery_sendhub(message)
    client = Sendhub::Client.new(
      :api_key => SENDHUB_API_KEY,
      :secret_key => SENDHUB_SECRET_KEY
    )
    res = client.send_email(
      :from => message.from,
      :to => message.to,
      :subject => message.subject,
      :body => message.body
    )
    
    puts res.inspect
  end

  def tag(value)
    @tag = value
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      alias_method_chain :create_mail, :tag
    end
  end

  def create_mail_with_tag
    returning create_mail_without_tag do |mail|
      mail.tag = @tag if @tag
    end
  end

  module ClassMethods
    def sendhub_api_key=(value)
      #Sendhub.api_key = value
    end
    def sendhub_secret_key=(value)
      #Sendhub.api_key = value
    end
  end

end

class ActionMailer::Base
  puts "***** MOOOOO *****"
  include SendhubMethods
end
