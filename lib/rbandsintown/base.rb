module Rbandsintown
  class Base
    def self.find_by(type, name, params = {})
      response = Rbandsintown.request("/artists/#{parse_name(type, name)}", params)
      Artist.new response
    end

    def method_missing(method_name, *args)
      attr = "@#{method_name}"
      super unless instance_variable_defined? attr

      instance_variable_get attr
    end

    private

    def self.parse_name(type, name)
      if type == 'artist'
        name.gsub!('&', 'And')
        name.gsub!('+', 'Plus')
        name = name.split.map { |w| w.capitalize }.join if name =~ /\s/
        name.gsub!('/', CGI.escape('/'))
        name.gsub!('?', CGI.escape('?'))
        URI.escape(name)
      else
        "mbid_#{name}"
      end
    end
  end
end
