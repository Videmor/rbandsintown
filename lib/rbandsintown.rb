require "rbandsintown/version"

require 'rbandsintown/base'
require 'rbandsintown/connection'
require 'rbandsintown/artist'
require 'rbandsintown/event'
require 'rbandsintown/venue'

module Rbandsintown
  class << self
    # All Bandsintown API requests require an app_id parameter for identification.
    # See http://www.bandsintown.com/api/authentication for more information.
    attr_accessor :app_id
  end
end
