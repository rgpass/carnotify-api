class Car
  def self.makes_by_year(year)
    HTTParty.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484&year=#{year}")['makes']
  end

  def self.maintenance_list_for_model_year_id(model_year_id)
    maintenance_list = HTTParty.get("https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=#{model_year_id}&fmt=json&api_key=jfc7fztasc6vfbaqzmfnw484")['actionHolder']
    maintenance_list.sort_by! { |item| item['intervalMileage'] }
    intervals = maintenance_list.map { |item| item['intervalMileage'] }.uniq
    intervals.map { |interval| [{ mileage: interval, items: maintenance_list.select { |item| item['intervalMileage'] == interval }}] }
  end
end