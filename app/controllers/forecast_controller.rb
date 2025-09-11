# frozen_string_literal: true
require "ostruct"

class ForecastController < ApplicationController
  def index
    if params[:address].present?
      address = params[:address]
      
      log_request(address)
      
      @from_cache = Rails.cache.exist?(address)

      result = Rails.cache.fetch(address, expires_in: 30.minutes) do
        get_weather_for(address)
      end

      if result.success?
        @forecast = result.data
      else
        log_failure(address, result.error_message)
        flash.now[:alert] = result.user_message
        @forecast = nil
      end
    end
  end

  private

  def get_weather_for(address)
    api_key = ENV['OPENWEATHER_API_KEY'] || Rails.application.credentials.openweathermap[:api_key]

    unless api_key
      return OpenStruct.new(success?: false, user_message: "Service temporarily unavailable.", error_message: "OpenWeatherMap API key is missing.")
    end
    
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{ERB::Util.url_encode(address)}&appid=#{api_key}&units=metric&lang=en"

    begin
      response = HTTParty.get(url, timeout: 5)

      case response.code
      when 200
        OpenStruct.new(success?: true, data: JSON.parse(response.body))
      when 401
        OpenStruct.new(success?: false, user_message: "Service temporarily unavailable.", error_message: "OpenWeatherMap API key is invalid or unauthorized (401)")
      when 404
        OpenStruct.new(success?: false, user_message: "Location not found. Please check the address.", error_message: "Invalid location (404)")
      else
        OpenStruct.new(success?: false, user_message: "An error occurred. Please try again later.", error_message: "API returned non-200 status: #{response.code}")
      end
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      OpenStruct.new(success?: false, user_message: "The weather service is not responding.", error_message: "Connection Timeout: #{e.message}")
    end
  end

  def log_request(address)
    Rails.logger.info "Forecast query address: \"#{address}\""
  end

  def log_failure(address, error)
    Rails.logger.warn "Forecast Failure address: \"#{address}\", error: #{error}"
  end
end