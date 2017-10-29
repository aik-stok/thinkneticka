
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
    trains.each {|train| p train.number}
  end
  
  def quantity_of_type(word_type)
    quantity = 0
    trains.each {|train| quantity += 1 if train.type == word_type}
    return "There is #{quantity} #{word_type} trains on station right now."
  end

  def depart(train)
    trains.delete(train)
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
  attr_reader :number, :type, :route
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
      "You should stop the train first"
    end
  end

  def get_route(route)
    route.stations.first.arrive(self)
    @current_station = 0
    @route = route
  end

  def move_to_next
    unless @current_station + 1 > @route.stations.size - 1
    @previous_station = @current_station
    @route.stations[@current_station].depart(self)
    @current_station += 1
    @route.stations[@current_station].arrive(self)
    else
      "You already on last station"
    end
  end

  def move_back
    unless @current_station - 1 == -1
    @previous_station = @current_station
    @route.stations[@current_station].depart(self)
    @current_station -= 1
    @route.stations[@current_station].arrive(self)
    else 
      "You already on first station"
    end
  end
  
  def show_previous_station
    unless @previous_station == nil
      p @route.stations[@previous_station].name
    else
      "Just recived route, no previous stations yet!"
    end
  end
  
  def show_current_station
    @route.stations[@current_station].name
  end
    
  def show_next_station
    if @current_station + 1 <= @route.stations.size - 1
      @route.stations[@current_station].name
    else
      "This is last station"
    end
  end
end 

