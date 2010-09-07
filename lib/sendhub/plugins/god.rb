require 'sendhub'

module God
  module Contacts
    class Sendhub < Contact
      class << self
        attr_accessor :api_key, :secret_key, :from
      end
      
      def valid?
        valid = true
        valid &= complain("Attribute 'api_key' must be specified", self) unless arg(:api_key)
        valid &= complain("Attribute 'secret_key' must be specified", self) unless arg(:secret_key)
        valid &= complain("Attribute 'from' must be specified", self) unless arg(:from)
        valid
      end
      
      attr_accessor :to
      
      def notify(message, time, priority, category, host)
        puts "#{message}"
        data = {
          :message => message,
          :time => time,
          :priority => priority,
          :category => category,
          :host => host
        }
        
        client = ::Sendhub::Client.new(:api_key => arg(:api_key), :secret_key => arg(:secret_key))
        res = client.send_email(
          :from => arg(:from),
          :to => arg(:to),
          :subject => "[god] #{message}",
          :body => data.inspect
        )
        
        applog(nil, :info, res.inspect)
      rescue Object => e
        applog(nil, :info, "failed to send email to #{arg(:to)}: #{e.message}")
        applog(nil, :debug, e.backtrace.join("\n"))
      end
    end
  end
end