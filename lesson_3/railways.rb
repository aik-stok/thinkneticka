
class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train
  end

  def quantity_of_type(word_type)
    trains.count {|train| train.type == word_type}
  end

  def depart(train)
    trains.delete(train)
  end
end

class Route
  attr_reader :stations
  def initialize(first_st, last_st)
    @stations = [] << first_st << last_st
  end
  
  def add_station(station)
    stations.insert(-2,station)
  end
  
  def delete_station(station_name)
    stations.reject!.with_index { |element,index| element.name == station_name && ![0,stations.size - 1].member?(index) }
  end
end


class Train
  attr_reader :number, :type, :route, :wagon_quantity

  def initialize(number, type, wagon_quantity)
    @number = number
    @type = type
    @wagon_quantity = wagon_quantity
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

  def operate_wagon(operation)
    if @speed == 0
      case operation
        when "engage" then @wagon_quantity += 1
        when "disengage" then @wagon_quantity -= 1 
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
      current_station.depart(self)
      @current_station += 1
      current_station.arrive(self)
    else
      "You already on last station"
    end
  end

  def move_back
    unless @current_station == 0
      current_station.depart(self)
      @current_station -= 1
      current_station.arrive(self)
    else 
      "You already on first station"
    end
  end
  
  def show_previous_station
    unless @current_station == 0
      @route.stations[@current_station - 1]
    else
      "Just recived route or you already on previous station!"
    end
  end
  
  def current_station
    @route.stations[@current_station]
  end
    
  def show_next_station
    if @current_station + 1 <= @route.stations.size - 1
      @route.stations[@current_station + 1]
    else
      "This is last station"
    end
  end
end 
