require 'time'

module Rbandsintown
  class Event < Base
    def initialize(options = {})
      @id                 = options['id']
      @title              = options['title']
      @datetime           = Time.parse(options['datetime'])
      @formatted_datetime = options['formatted_datetime']
      @formatted_location = options['formatted_location']
      @ticket_url         = options['ticket_url']
      @ticket_type        = options['ticket_type']
      @ticket_status      = options['ticket_status']
      @on_sale_datetime   = options['on_sale_datetime']
      @facebook_rsvp_url  = options['facebook_rsvp_url']
      @description        = options['description']
      @artists            = options['artists']
      @venue              = Rbandsintown::Venue.new options['venue']
    end

    # Returns events for a single artist matching search criteria
    # @required
    #     artists or location
    # See http://www.bandsintown.com/api/1.0/requests#events-search
    # See http://www.bandsintown.com/api/requests#artists-event-search
    # @example
    #    events = Rbandsintown::Event.search(artists: ['Aerosmith'], location: 'Lima')
    #    events = Rbandsintown::Event.search(artists: ['mbid_b929c0c9-5de0-4d87-8eb9-365ad1725629'], location: 'Lima')
    #    events = Rbandsintown::Event.search(location: 'Lima')
    #    events = Rbandsintown::Event.search(location: 'Lima', artists: ['Aerosmith', 'Richie Ramone'], radius: 8, start_date: 1.month.from_now, end_date: 5.month.from_now)
    def self.search(options = {})
      response = Rbandsintown.request('/events/search', options)
      response.map { |data| Rbandsintown::Event.new data }
    end

    # Returns recommended events for a single artist matching search criteria
    # @required
    #     artists and location
    # See http://www.bandsintown.com/api/1.0/requests#events-recommended
    # See http://www.bandsintown.com/api/requests#artists-recommended-events
    # @example
    #     events = Rbandsintown::Event.recommended(artists: ['Led Zeppelin'], location: 'Boston, MA')
    def self.recommended(options = {})
      response = Rbandsintown.request('/events/recommended', options)
      response.map { |data| Rbandsintown::Event.new data }
    end

    # Returns events going on sale in the next week (including today). Supports location filtering.
    # See http://www.bandsintown.com/api/1.0/requests#events-on-sale-soon
    # @example
    #     Rbandsintown::Event.on_sale_soon( location: "Lima", radius: 10 )
    def self.on_sale_soon(options = {})
      response = Rbandsintown.request('/events/on_sale_soon', options)
      response.map { |data| Rbandsintown::Event.new data }
    end

    # Returns events that have been created, updated or deleted in the last day. Useful in syncing data with Bandsintown.
    # See http://www.bandsintown.com/api/1.0/requests#events-daily
    # @example
    #     Rbandsintown::Event.daily
    def self.daily
      response = Rbandsintown.request('/events/daily')
      response.map { |data| Rbandsintown::Event.new data }
    end
  end
end