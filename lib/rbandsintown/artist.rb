module Rbandsintown
  class Artist < Base
    # Returns basic information for a single artist
    # See http://www.bandsintown.com/api/requests#artists-get
    # @example
    #     # using artist name
    #     artist = Rbandsintown::Artist.find("ACD/DC")
    def self.find(name, options = {})
      self.request(parse_name(name), options)
    end

    # Returns basic information for a single artist
    # See http://www.bandsintown.com/api/requests#artists-get
    # @example
    #     # using artist mbid
    #     artist = Rbandsintown::Artist.find_mbid("b929c0c9-5de0-4d87-8eb9-365ad1725629")
    def self.find_mbid(mbid, options = {})
      self.request("mbid_#{mbid}", options)
    end

    def initialize(options = {})
      @name                     = options['name']
      @image_url                = options['image_url']
      @thumb_url                = options['thumb_url']
      @facebook_tour_dates_url  = options['facebook_tour_dates_url']
      @facebook_page_url        = options['facebook_page_url']
      @mbid                     = options['mbid']
      @upcoming_event_count     = options['upcoming_event_count']
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
      return [] unless name
      response = Rbandsintown.request("/artists/#{self.class.parse_name(name)}/events", options)
      response.map { |data| Event.new data }
    end

    def tour?
      @upcoming_event_count > 0
    end

    def self.resource
      'artist'
    end

    private

    def self.parse_name(name)
      name.gsub!('&', 'And')
      name.gsub!('+', 'Plus')
      name.gsub!('"', '')
      name = name.split.map { |w| w.capitalize }.join if name =~ /\s/
      name.gsub!('/', CGI.escape('/'))
      name.gsub!('?', CGI.escape('?'))
      URI.escape(name)
    end
  end
end
