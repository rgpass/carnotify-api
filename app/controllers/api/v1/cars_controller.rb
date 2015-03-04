class Api::V1::CarsController < ApplicationController
  def makes
    @makes = Car.makes_by_year(params[:year])
  end

  def maintenance
    model_year_id = params[:modelyearid]
    @maintenance_list = Car.maintenance_list_for_model_year_id(model_year_id)
  end
end