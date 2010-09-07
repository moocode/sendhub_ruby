require 'uri'
require 'net/http'
require 'digest/sha1'

require 'rubygems'
require 'json'

module Sendhub
end

require 'sendhub/http'
require 'sendhub/response'
require 'sendhub/client'

if defined? Rails
  if Rails.version =~ /^2./
    require 'action_mailer'
    require 'sendhub/plugins/rails2'
  elsif Rails.version =~ /^3./
    require 'sendhub/plugins/rails3'
  end
end