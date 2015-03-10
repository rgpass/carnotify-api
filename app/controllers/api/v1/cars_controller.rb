class Api::V1::CarsController < ApplicationController
  def makes
    @makes = Car.makes_by_year(params[:year])
  end

  def maintenance
    @model_year = Car.model_year_by_nice_names(params[:year], params[:make], params[:model])
    model_year_id = @model_year[:id]
    @maintenance_list = Car.maintenance_list_for_model_year_id(model_year_id)
    # render json: @model_year, status: 200
  end
end
