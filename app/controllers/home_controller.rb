require 'net/http'
require 'json'
class HomeController < ApplicationController
  API_KEY = '1F8E1EC8-7E22-408D-ABED-C04FC185268B'.freeze
  WEATHERAPI_KEY = 'ade2b4020df645bdb8354554252203'.freeze

  def index
    @zipcode = params[:zipcode] || '95126'
    
    begin
      @url = "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zipcode}&distance=50&API_KEY=#{API_KEY}"
      @response = Net::HTTP.get(URI.parse(@url))
      @output = JSON.parse(@response)

      if valid_response?
        process_successful_response
      else
        process_error_response
      end
    rescue StandardError => e
      process_api_error(e)
    end

    begin
      current_url = "http://api.weatherapi.com/v1/current.json?key=#{WEATHERAPI_KEY}&q=#{@zipcode}&aqi=no"
      response = Net::HTTP.get(URI.parse(current_url))
      @current_weather = JSON.parse(response)
        rescue => e
      @current_weather_error = "Current weather data unavailable"
    end

    begin
      forecast_url = "http://api.weatherapi.com/v1/forecast.json?key=#{WEATHERAPI_KEY}&q=#{@zipcode}&days=7&aqi=no&alerts=no"
      response = Net::HTTP.get(URI.parse(forecast_url))
      @forecast = JSON.parse(response)
        rescue => e
      @forecast_error = "Forecast data unavailable"
    end
    set_color_scheme
  end

  private

  def valid_response?
    @output.is_a?(Array) && @output.any?
  end

  def process_successful_response
    ozone_data = @output.find { |item| item['ParameterName'] == 'O3' }
    @final_output = ozone_data['AQI']
    @reporting_area = "#{ozone_data['ReportingArea']}, #{ozone_data['StateCode']}"
    @category_name = ozone_data.dig('Category', 'Name')
  rescue
    process_error_response
  end

  def process_error_response
    @final_output = "N/A"
    @reporting_area = "No data available"
    @category_name = "Unknown"
  end

  def process_api_error(exception)
    Rails.logger.error "API Error: #{exception.message}"
    @final_output = "Error"
    @reporting_area = "Service unavailable"
    @category_name = "Error"
  end

  def set_color_scheme
    @api_color = case @final_output.to_i
    when 0..50 then 'green'
    when 51..100 then 'yellow'
    when 101..150 then 'orange'
    when 151..200 then 'red'
    when 201..300 then 'purple'
    when 301..500 then 'maroon'
    else 'gray'
    end
  end
end
