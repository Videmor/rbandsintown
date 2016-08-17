require 'httparty'

module Rbandsintown
  include HTTParty
  base_uri 'http://api.bandsintown.com'

  API_VERSION = '2.0'

  class << self
    def request(path, query_params = {})
      response = self.get(path, query: self.encode(query_params))

      if response.success?
        response
      else
        raise response['errors'].join(', ')
      end
    end

    def encode(params = {})
      start_date = params.delete(:start_date)
      end_date   = params.delete(:end_date)
      if start_date && end_date
        start_date  = start_date.strftime("%Y-%m-%d") unless start_date.is_a?(String)
        end_date    = end_date.strftime("%Y-%m-%d")   unless end_date.is_a?(String)
        params[:date] = "#{start_date},#{end_date}"
      elsif params.has_key?(:date)
        params[:date] = params[:date].strftime("%Y-%m-%d") unless params[:date].is_a?(String)
      end

      params[:api_version] = API_VERSION
      params[:app_id] = Rbandsintown.app_id
      params[:format] ||= 'json'

      params.to_param
    end
  end
end
