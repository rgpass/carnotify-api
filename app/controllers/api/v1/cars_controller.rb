class Api::V1::CarsController < ApplicationController
  # respond_to :json

  def makes
    year = params[:year]
    edmunds_makes = HTTParty.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484&year=#{year}")
    render json: edmunds_makes, status: 200#, location: [:api, user]
  end

  def maintenance
    model_year_id = params[:modelyearid]
    maintenance_list = HTTParty.get("https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484")['actionHolder']
    maintenance_list.sort_by! { |item| item['intervalMileage'] }
    intervals = maintenance_list.map { |item| item['intervalMileage'] }.uniq
    @maintenance_list = intervals.map { |interval| [{ mileage: interval, items: maintenance_list.select { |item| item['intervalMileage'] == i }}] }
  end
end