class Car
  def self.makes_by_year(year)
    HTTParty.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484&year=#{year}")['makes']
  end

  def self.labor_rate_by_zip(zip)
    url = "https://api.edmunds.com/v1/api/maintenance/ziplaborrate/#{zip}?fmt=json&api_key=n4vkddcrjxxhve79sxn9bqaj"
    HTTParty.get(url)['zipLaborRateHolder'][0]
  end

  def self.model_year_by_nice_names(year, make, model)
    url = "https://api.edmunds.com/api/vehicle/v2/#{make}/#{model}/#{year}?view=full&fmt=json&api_key=n4vkddcrjxxhve79sxn9bqaj"
    full_info = HTTParty.get(url)
    { year: full_info['year'], make: full_info['make']['name'],
      model: full_info['model']['name'], id: full_info['id'] }
  end

  def self.maintenance_by_model_year_id(model_year_id)
    url = "https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484"
    maintenance_list = HTTParty.get(url)['actionHolder']
    maintenance_list.sort_by! { |item| item['intervalMileage'] }
    intervals = maintenance_list.map { |item| item['intervalMileage'] }.uniq
    interval_summary = intervals.map { |interval| { mileage: interval, items: maintenance_list.select { |item| item['intervalMileage'] == interval }.uniq { |item| item['itemDescription'] } } }
  end

  def self.include_costs(maintenance_list, labor_rate)
    maintenance_list.map do |interval|
      interval[:items].map do |item|
        labor_cost = item['laborUnits'] * labor_rate
        part_units = item['partUnits'] || 0
        part_cost_per_unit = item['partCostPerUnit'] || 0
        parts_cost = part_units * part_cost_per_unit
        item.merge!(labor_cost: labor_cost, parts_cost: parts_cost)
      end

      sum_labor_cost = interval[:items].sum { |item| item[:labor_cost] }
      sum_parts_cost = interval[:items].sum { |item| item[:parts_cost] }
      interval.merge!(sum_labor_cost: sum_labor_cost, sum_parts_cost: sum_parts_cost)
    end
  end
end
