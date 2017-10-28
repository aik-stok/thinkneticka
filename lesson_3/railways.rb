
class Station
  attr_accessor :trains
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train
  end

  def show_all_trains
    p "All trains currently on station:"
    trains.each {|train| p train.number}
  end
  def show_all_by_type
    passanger = 0
    cargo = 0
    trains.each {|train| train.type == "passenger" ? passanger += 1 : cargo += 1}
    return "There is #{passanger} passenger trains and #{cargo} cargo trains on station right now."
  end

  def depart(train)
    trains.reject! {|index| index == train}
  end
end

class Route
  attr_accessor :stations
  def initialize(first_st, last_st)
    @stations = [] << first_st << last_st
  end
  
  def add_station(station)
    stations.insert(-2,station)
  end
  
  def delete_station(station_name)
    stations.reject!.with_index { |element,index| element.name == station_name && ![0,stations.size - 1].member?(index) }
  end
  
  def show_all_stations
    stations.each {|station| p station}
  end
end


class Train
  attr_reader :number
  attr_reader :type
  attr_accessor :wagon_quantity
  attr_reader :route

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
    route.stations.first.arrive(self)
    @current_station = route.stations.first
    @route = route
  end
  def movement(operator)
    next_station_index = @route.stations.find_index(@current_station).send(operator,1)
    @previous_station = @current_station
    @current_station.depart(self)
    @route.stations[next_station_index].arrive(self)
    @current_station = @route.stations[next_station_index]
  end
  def move_to_next
    movement(:+)
  end

  def move_back
    movement(:-)
  end
  
  def show_previous_station
    p @previous_station.name
  end
end 

train1 = Train.new(899,"cargo",10)
train2 = Train.new(123,"passenger",10)
train3 = Train.new(1001,"passenger",8)
train4 = Train.new(588,"cargo",15)
station1 = Station.new("Vilnus")
station2 = Station.new("Minsk")
station3 = Station.new("Moskva")
station4 = Station.new("St.Pt")
route = Route.new(station1, station2)
train1.get_route(route)
