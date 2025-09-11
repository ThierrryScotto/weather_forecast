class ForecastController < ApplicationController
  def index
    if params[:address].present?
      address = params[:address]
      
      @from_cache = Rails.cache.exist?(address)

      @forecast = Rails.cache.fetch(address, expires_in: 30.minutes) do
        get_weather_for(address)
      end
    end
  end

  private

  def get_weather_for(address)
    api_key = ENV['OPENWEATHER_API_KEY'] || Rails.application.credentials.openweathermap[:api_key]

    raise "API key not found" unless api_key

    url = "https://api.openweathermap.org/data/2.5/weather?q=#{ERB::Util.url_encode(address)}&appid=#{api_key}&units=metric&lang=en"

    begin
      response = HTTParty.get(url)
      response.code == 200 ? JSON.parse(response.body) : nil
    rescue StandardError
      nil
    end
  end
end