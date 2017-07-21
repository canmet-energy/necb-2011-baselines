require 'json'

simulations_json_folder = "."
File.open("#{simulations_json_folder}/index_map.json", 'wb'){|f|
  sim = JSON.parse(File.read("#{simulations_json_folder}/simulations.json"))
  out = {}
  out["building_type"] = []
  out["cities"] = []
  out["id"] = {}
  out["datapoint"] = {}
  sim.each_with_index { |datapoint, i|
    out["id"]["#{datapoint['run_uuid']}"] = i
    out["building_type"] << datapoint['building_type']
    out["cities"] << datapoint['geography']['city']
    out["datapoint"]["#{datapoint['building_type']}"] = {} unless out["datapoint"].has_key?("#{datapoint['building_type']}")
    out["datapoint"]["#{datapoint['building_type']}"]["#{datapoint['geography']['city']}"] = [] unless out["datapoint"]["#{datapoint['building_type']}"].has_key?("#{datapoint['geography']['city']}")
    out["datapoint"]["#{datapoint['building_type']}"]["#{datapoint['geography']['city']}"] << "#{datapoint['run_uuid']}"
  }
  out["building_type"].uniq!
  out["cities"].uniq!
  f.write(JSON.pretty_generate(out))
}