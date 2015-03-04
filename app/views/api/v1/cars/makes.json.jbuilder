json.array!(@makes) do |make|
  json.name       make['name']
  json.niceName   make['niceName']
  json.models do
    json.array!(make['models']) do |model|
      json.name       model['name']
      json.niceName   model['niceName']
      json.id         model['years'][0]['id']
    end
  end
end

