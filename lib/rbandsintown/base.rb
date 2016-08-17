module Rbandsintown
  class Base
    def self.request(path, params = {})
      response = Rbandsintown.request("/#{self.resource}s/#{path}", params)
      type_class = Rbandsintown.const_get(self.resource.capitalize)

      if response.is_a? Array
        response.map { |data| type_class.new(data) if data }
      else
        type_class.new response
      end
    end

    def method_missing(method_name, *args)
      attr = "@#{method_name}"
      super unless instance_variable_defined? attr

      instance_variable_get attr
    end
  end
end
