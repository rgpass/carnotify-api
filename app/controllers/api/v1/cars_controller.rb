class Api::V1::CarsController < ApplicationController
  def makes
    @makes = Car.makes_by_year(params[:year])
  end

  def maintenance
    @labor_rate_info = Car.labor_rate_by_zip(params[:zip])
    @model_year = Car.model_year_by_nice_names(params[:year], params[:make], params[:model])
    model_year_id = @model_year[:id]
    maintenance_list = Car.maintenance_by_model_year_id(model_year_id)
    labor_rate = @labor_rate_info['laborRate']
    @maintenance_list = Car.include_costs(maintenance_list, labor_rate)
  end
end
