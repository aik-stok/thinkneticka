class Train
  include Manufacturer
  attr_reader :number, :route, :wagons
  @@instances = {}
  NUMBER_FORMAT = /^[\w\d]{3}\-?[\w\d]{2}$/

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    validate!
    @@instances[self.number] = self
  end

  def self.find(num)
    result = @@instances[num.to_s]
  end

  def engage_wagon(wagon)
    if @speed == 0
      wagon.type == type ? @wagons << wagon : 'Wagon of different type'
    else
      p 'You should stop the train first'
    end
  end

  def disengage_wagon(wagon)
    if @speed == 0
      !@wagons[0].nil? ? @wagons.delete(wagon) : (p 'Nothing to disengage')
    else
      'You should stop the train first'
    end
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  def get_route(route)
    route.stations.first.arrive(self)
    @current_station = 0
    @route = route
  end

  def move_to_next
    if !@current_station.nil?
      if @current_station + 1 > @route.stations.size - 1
        p 'You already on last station'
      else
        current_station.depart(self)
        @current_station += 1
        current_station.arrive(self)
      end
    else
      p 'No route assigned to train'
    end
  end

  def move_back
    if !@current_station.nil?
      if @current_station == 0
        p 'You already on first station'
      else
        current_station.depart(self)
        @current_station -= 1
        current_station.arrive(self)
      end
    else
      p 'No route assigned to train'
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  protected # used by subclasses, but not used by UI

  def show_previous_station
    if @current_station == 0 || @route.nil?
      p 'Not received route or you already on previous station!'
    else
      @route.stations[@current_station - 1]
    end
  end

  def current_station
    @route.stations[@current_station]
  end

  def show_next_station
    if @current_station + 1 <= @route.stations.size - 1
      @route.stations[@current_station + 1]
    else
      p 'This is last station'
    end
  end

  def speed_up
    @speed += 10
  end

  def current_speed
    p @speed
  end

  def stop
    @speed = 0
    p 'Stopped'
  end

  def validate!
    raise 'No number inputed' if number.nil?
    raise 'Entered incorrect number' if number !~ NUMBER_FORMAT
    true
  end
end
