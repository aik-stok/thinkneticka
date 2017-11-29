class Train
  include Manufacturer
  include Validation
  extend Acessors
  attr_accessor_with_history :number, :route, :wagons
  validate :number, :presence
  validate :number, :format, /^[\w\d]{3}\-?[\w\d]{2}$/

  @@instances = {}


  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @@instances[self.number] = self
  end

  def self.find(num)
    @@instances[num.to_s]
  end

  def engage_wagon(wagon)
    if @speed.zero?
      wagon.type == type ? @wagons << wagon : 'Wagon of different type'
    else
      p 'You should stop the train first'
    end
  end

  def disengage_wagon(wagon)
    if @speed.zero?
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
    else p 'No route assigned to train'
    end
  end

  def move_back
    if !@current_station.nil?
      if @current_station.zero?
        p 'You already on first station'
      else
        current_station.depart(self)
        @current_station -= 1
        current_station.arrive(self)
      end
    else p 'No route assigned to train'
    end
  end

  protected # used by subclasses, but not used by UI

  def show_previous_station
    if @current_station.zero? || @route.nil?
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

end
