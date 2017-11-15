class Route
  attr_reader :stations
  def initialize(first_st, last_st)
    @stations = [] << first_st << last_st
    validate!
  end
  
  def add_station(station)
    stations.insert(-2,station)
  end
  
  def delete_station(station)
    stations.reject!.with_index { |element,index| element == station_name && ![0,stations.size - 1].member?(index) }
  end
  
  def valid?
    validate!
  rescue
    false
  end
  
  protected

  def validate!
    raise "No first station received" if first_st.nil?
    raise "No last station received" if last_st.nil?
    raise "First and last are actually the same station" if first_st == last_st
    true
  end

end
