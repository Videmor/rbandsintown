module Rbandsintown
  class Venue < Base
    def initialize(options = {})
      @name     = options['name']
      @place    = options['place']
      @city     = options['city']
      @region   = options['region']
      @country  = options['country']
      @latitude = options['latitude']
      @longitude= options['longitude']
    end
  end
end
