class WeathersController < ApplicationController
  before_action :require_user_logged_in!

  def index
  end

  def search
    country = find_country(params[:country])
    if country.nil?
      redirect_to report_path, notice: "Invalid input" and return 
    end
    country = country.first
    weather_report = find_report(country["lat"], country["lon"])
    @report = {
      "Name": country["name"], 
      "weather": weather_report["weather"].first["description"],
      "temperature": weather_report["main"]["temp_min"] - 273
    }
  end 

  private

  def find_report(lat, lon)
    api_key = "d888469d9fdf2ef5b7f45cf8740dd4f7"
    request_api(
      "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{api_key}"
    )   
  end

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def find_country(name)
    api_key = "d888469d9fdf2ef5b7f45cf8740dd4f7"

    request_api(
      "http://api.openweathermap.org/geo/1.0/direct?q=#{name}&limit=#{1}&appid=#{api_key}"
    )
  end
end