
class Station
  attr_accessor :trains
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = {}
  end

  def arrive(train)
    @trains[train.number] = {train.type => train.wagon_quantity}
  end

  def show_all_trains
    p "All trains currently on station:"
    trains.each {|number, value| p number}
  end
  def show_all_by_type
    passanger = 0
    cargo = 0
    trains.each do |number, value| 
    value.each {|type, wagons| type == "passenger" ? passanger += 1 : cargo += 1}
    end
    return "There is #{passanger} passenger trains and #{cargo} cargo trains on station right now."
  end

  def depart(train)
    trains.delete(train.number)
  end
end

class Route
    attr_accessor :stations
  def initialize(first_st, last_st)
    @stations = [] << first_st.name << last_st.name
  end
  
  def add_station(station)
    stations.insert(-2,station.name)
  end
  
  def delete_station(station)
    stations.reject!.with_index { |element,index| element == station.name && ![0,stations.size - 1].member?(index) }
  end
  
  def show_all_stations
    stations.each {|station| p station}
  end
end


class Train
  attr_reader :number
  attr_reader :type
  attr_accessor :wagon_quantity


  def initialize(number, type, wagon_quantity)
    @number = number
    @type = type
    @wagon_quntity = wagon_quantity
    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def current_speed
    p @speed
  end

  def stop
    @speed = 0
    p "Stopped"
  end

  def wagon_quantity
    p @wagon_quntity
  end

  def operate_wagon(operation)
    if @speed == 0
      case operation
        when "engage" then @wagon_quntity += 1
        when "disengage" then @wagon_quntity -= 1 
      end
    else 
      p "You should stop the train first"
    end
  end

  def get_route(route)
    1route.stations[0] 
    
  end

  def next_station
  end

  def previous
  end

end 
