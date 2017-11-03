class Train
  attr_reader :number, :type, :route, :wagons

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  protected # beacause it not used under UI, but may be used by subclasses (someday) and to protect from train wreck =)

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

  public #there is no show without this methods

  def engage_wagon(wagon)
    if @speed == 0
     wagon.type == self.type ? @wagons << wagon : "Wagon of different type"
    else
      p "You should stop the train first"
    end
  end

  def disengage_wagon(wagon)
    if wagon.type == self.type
      if @speed == 0 
        @wagons[0] != nil ? @wagons.delete(@wagons[0]) : (p "Nothing to disengage")
      else
        p "You should stop the train first"
      end
    else
      p "Wagon of different type"
    end
  end

  def get_route(route)
    route.stations.first.arrive(self)
    @current_station = 0
    @route = route
  end

  def move_to_next
    if @current_station != nil
      unless @current_station + 1 > @route.stations.size - 1
        current_station.depart(self)
        @current_station += 1
        current_station.arrive(self)
      else
        p "You already on last station"
      end
    else
      p "No route assigned to train"
    end
  end

  def move_back
    if @current_station != nil
      unless @current_station == 0
        current_station.depart(self)
        @current_station -= 1
        current_station.arrive(self)
      else 
        p "You already on first station"
      end
    else
      p "No route assigned to train"
    end
  end

  protected #used by subclasses, but not used by UI

  def show_previous_station
    unless @current_station == 0 || @route == nil
      @route.stations[@current_station - 1]
    else
      p "Not received route or you already on previous station!"
    end
  end
  
  def current_station
    @route.stations[@current_station]
  end
    
  def show_next_station
    if @current_station + 1 <= @route.stations.size - 1
      @route.stations[@current_station + 1]
    else
      p "This is last station"
    end
  end
end 
