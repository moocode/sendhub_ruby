require 'uri'
require 'net/http'
require 'digest/sha1'

require 'rubygems'
require 'json'

module Sendhub
end

if ENV['RAILS_ENV']
  require 'action_mailer'
  require 'sendhub/rails'
end

require 'sendhub/http'
require 'sendhub/response'
require 'sendhub/client'