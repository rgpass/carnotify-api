class Api::V1::CarsController < ApplicationController
  # respond_to :json

  def makes
    year = params[:year]
    edmunds_makes = HTTParty.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484&year=#{year}")
    render json: edmunds_makes, status: 200#, location: [:api, user]
  end
end