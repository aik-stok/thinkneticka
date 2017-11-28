class Route
  attr_reader :stations

  def initialize(first_st, last_st)
    @stations = [first_st, last_st]
    validate!
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.reject!.with_index do |element, index| 
      element == station && ![0, stations.size - 1].member?(index)
    end
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise 'No first station received' if @stations[0].nil?
    raise 'No last station received' if @stations[1].nil?
    raise 'First and last are actually the same station' if @stations[0] == @stations[1]
    true
  end

end