# Rbandsintown

This is a ruby wrapper for the Bandsintown API.

For more information visit http://www.bandsintown.com/api/overview

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rbandsintown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbandsintown

## Usage

### Requiring

  require 'rbandsintown'

### Setting the bandsintown app_id parameter

  Rbandsintown.app_id = 'YOUR_APP_ID'

### Find basic information about an artist

  artist = Rbandsintown::Artist.find("AC/DC")
  artist.name                 #=> "AC/DC"
  artist.image_url            #=> "https://s3.amazonaws.com/bit-photos/large/6839662.jpeg" 
  artist.upcoming_event_count #=> 11
  artist.on_tour?             #= true

### Find all upcoming events for a given artist

  artist = Rbandsintown::Artist.find("ACD/DC")
  events = artist.events

### Find all upcoming events for a given artist using mbid (music brainz id)
  
  artist = Rbandsintown::Artist.find_mbid("b929c0c9-5de0-4d87-8eb9-365ad1725629")
  events = artist.events

### Find events matching search criteria 

  events = Rbandsintown::Event.search(artists: ['Aerosmith'], location: 'Lima')

  events = Rbandsintown::Event.search(artists: ['mbid_b929c0c9-5de0-4d87-8eb9-365ad1725629'], location: 'Lima')

  events = Rbandsintown::Event.search(location: 'Lima')

  events = Rbandsintown::Event.search(location: 'Lima', artists: ['Aerosmith', 'Richie Ramone'], radius: 8, start_date: Time.now, end_date: 1.month.from_now)

### Find recommended events around Lima for fans of Slipknot

  events = Rbandsintown::Event.recommended(artists: ['Slipknot'], location: 'Lima')

### Find events going on sale in the next week 

  events = Rbandsintown::Event.on_sale_soon( location: "Lima", radius: 10 )

### Find events that have been created/updated/deleted in the last day

  events = Bandsintown::Event.daily

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rbandsintown. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

