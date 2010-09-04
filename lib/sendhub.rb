require 'uri'
require 'net/http'
require 'digest/sha1'

require 'rubygems'
require 'json'

module Sendhub
end

if defined? Rails
  if Rails.version =~ /^2./
    require 'sendhub/rails2'
  elsif Rails.version =~ /^3./
    require 'sendhub/rails3'
  end
end

require 'sendhub/http'
require 'sendhub/response'
require 'sendhub/client'