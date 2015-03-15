class Car
  def self.makes_by_year(year)
    HTTParty.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484&year=#{year}")['makes']
  end

  def self.model_year_by_nice_names(year, make, model)
    url = "https://api.edmunds.com/api/vehicle/v2/#{make}/#{model}/#{year}?view=full&fmt=json&api_key=n4vkddcrjxxhve79sxn9bqaj"
    full_info = HTTParty.get(url)
    { year: full_info['year'], make: full_info['make']['name'],
      model: full_info['model']['name'], id: full_info['id'] }
  end

  def self.maintenance_list_for_model_year_id(model_year_id)
    url = "https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484"
    maintenance_list = HTTParty.get(url)['actionHolder']
    maintenance_list.sort_by! { |item| item['intervalMileage'] }
    intervals = maintenance_list.map { |item| item['intervalMileage'] }.uniq
    intervals.map { |interval| { mileage: interval, items: maintenance_list.select { |item| item['intervalMileage'] == interval }.uniq { |item| item['itemDescription'] } } }
  end
end
