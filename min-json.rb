require 'json'

full_json = JSON.parse(File.read("./simulations.json"))

full_json.each { |datapoint|
  datapoint['envelope'].delete('constructions')
  datapoint.delete('spaces')
  datapoint.delete('thermal_zones')
  datapoint.delete('air_loops')
  datapoint.delete('plant_loops')
  datapoint.delete('eplusout_err')
  datapoint.delete('ruby_warnings')
  datapoint.delete('information')
  datapoint.delete('warnings')
  datapoint.delete('errors')
  datapoint.delete('unique_errors')
  datapoint.delete('sanity_check')
}
File.open("./min-simulations.json", 'wb'){|f|
  f.write(JSON.generate(full_json))
}
