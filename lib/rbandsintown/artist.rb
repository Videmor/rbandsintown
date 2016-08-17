module Rbandsintown
  class Artist < Base
    # Returns basic information for a single artist
    # See http://www.bandsintown.com/api/requests#artists-get
    # @example
    #     # using artist name
    #     artist = Rbandsintown::Artist.find("Little Brother")
    def self.find(name, options = {})
      self.find_by('artist', name, options)
    end

    # Returns basic information for a single artist
    # See http://www.bandsintown.com/api/requests#artists-get
    # @example
    #     # using artist mbid
    #     artist = Rbandsintown::Artist.find_mbid("b929c0c9-5de0-4d87-8eb9-365ad1725629")
    def self.find_mbid(mbid, options = {})
      self.find_by('mbid', mbid, options)
    end

    def initialize(options = {})
      @name                     = options['name']
      @image_url                = options['image_url']
      @thumb_url                = options['thumb_url']
      @facebook_tour_dates_url  = options['facebook_tour_dates_url']
      @facebook_page_url        = options['facebook_page_url']
      @mbid                     = options['mbid']
      @upcoming_events_count    = options['upcoming_events_count']
      @tracker_count            = options['tracker_count']
      @website                  = options['website']
      @url                      = options['url']
    end

    # Returns events for a single artist
    # See http://www.bandsintown.com/api/requests#artists-events
    # @example
    #     # using artist name
    #     artist = Rbandsintown::Artist.find("Little Brother")
    #     artist.events
    #
    #     # using mbid
    #     artist = Rbandsintown::Artist.find_mbid("b929c0c9-5de0-4d87-8eb9-365ad1725629")
    #     artist.events
    def events(options = {})
      return [] unless mbid
      response = Rbandsintown.request("/artists/mbid_#{mbid}/events", options)
      response.map { |data| Rbandsintown::Event.new data }
    end
  end
end
