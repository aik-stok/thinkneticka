class Route
  attr_reader :stations
  def initialize(first_st, last_st)
    @stations = [] << first_st << last_st
  end
  
  def add_station(station)
    stations.insert(-2,station)
  end
  
  def delete_station(station)
    stations.reject!.with_index { |element,index| element == station_name && ![0,stations.size - 1].member?(index) }
  end
end
