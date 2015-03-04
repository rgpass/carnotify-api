class Api::V1::CarsController < ApplicationController
  def makes
    edmunds_makes = Car.makes_by_year(params[:year])
    render json: edmunds_makes, status: 200
  end

  def maintenance
    model_year_id = params[:modelyearid]
    @maintenance_list = Car.maintenance_list_for_model_year_id(model_year_id)
  end
end