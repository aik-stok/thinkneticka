require_relative 'modules'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'


POST = "
       Put number of paragraph:
      1 Create stations
      2 Create trains
      3 Creatre route and manage stations
      4 Assign route to train
      5 Engage wagons
      6 Disengage wagons
      7 Manage wagon
      8 Move train to next station
      9 Move train to previous station
      10 Show stations and list of trains
      11 All trains and wagons on stations (yielded)
     ".freeze

class Base
  attr_reader :stations

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  METHODS = {
    1 => :add_station, 2 => :add_train, 3 => :manage_routes,
    4 => :assign_route, 5 => :engage_wagon, 6 => :disengage_wagon,
    7 => :manage_wagon, 8 => :forward, 9 => :backward,
    10 => :trains_on_station, 11 => :all_stations_and_trains, 12 => :st
  }.freeze

  def st
    p @trains[0]
  end

  def run
    loop do
      print POST
      answer = gets.chomp.to_i
      next unless (1..12).cover?(answer)
      menu(answer)
    end
  end

  def menu(answer)
    send METHODS[answer]
  end

  private

  def show_trains
    @trains.each_with_index { |train, ind| p "#{ind + 1}. #{train.number}" }
  end

  def show_routes
    @routes.each_with_index { |route, ind| p "#{ind + 1}. #{route}" }
  end

  def show_stations
    @stations.each_with_index { |station, ind| p "#{ind + 1}. #{station.name}" }
  end

  def add_station
    p 'Name your station'
    st_name = gets.chomp.to_s
    @stations << Station.new(st_name)
  end

  def create_train(num, type)
    if type == 1
    PassengerTrain.new(num).validate!
    @trains << PassengerTrain.new(num)
    else
    CargoTrain.new(num).validate!
    @trains << CargoTrain.new(num)
    end
    p 'Train created'
  end

  def add_train
    p 'Type of train: 1 - pass, 2 - cargo'
    tr_type = gets.chomp.to_i
    p 'Enter train number:'
    tr_number = gets.chomp
    create_train(tr_number, tr_type)
  rescue => e
    p e.message
    retry
  end

  def manage_routes
    p "'add' - add new route, 'manage' - manage existing"
    answer = gets.chomp
    case answer
    when 'add' then add_route

    when 'manage' then manage_one_route

    end
  end

  def create_route
    p 'Enter number of first station'
    first_st = gets.chomp.to_i - 1
    p 'Enter number of last station'
    last_st = gets.chomp.to_i - 1
    @routes << Route.new(@stations[first_st], @stations[last_st])
  end

  def add_route
    if !@stations.empty?
      show_stations
      create_route
      p 'Route created'
    else
      p 'No stations to create route'
    end
  end

  def add_to_route(route_index)
    p 'Enter number of station to add'
    show_stations
    answer = gets.chomp.to_i - 1
    @routes[route_index].add_station(@stations[answer])
  end

  def remove_from_route(route_index)
    show_stations
    p 'Enter number of station to remove'
    answer = gets.chomp.to_i - 1
    @routes[route_index].delete_station(@stations[answer])
  end

  def answering
    route_index = gets.chomp.to_i - 1
    p '1 -- add, 2 -- delete'
    choice = gets.chomp.to_i
    case choice
    when 1 then add_to_route(route_index)
    when 2 then remove_from_route(route_index)
    end
  end

  def manage_one_route
    if @routes.empty?
      p 'No existing routes'
    else
      show_routes
      p 'Choose route'
      answering
    end
  end

  def assign_route_input
    train_index = gets.chomp.to_i - 1
    p 'Choose route number:'
    show_routes
    route_index = gets.chomp.to_i - 1
    @trains[train_index].get_route(@routes[route_index])
    p 'Route assigned'
  end

  def assign_route
    if @trains.empty? || @routes.empty?
      p 'Trains or route is absent'
    else
      p 'Enter train index: '
      show_trains
      assign_route_input
    end
  end

  def create_cargo_wagon
    p 'Enter capacity:'
    quantity = gets.chomp.to_i
    @trains[@train_number].engage_wagon(CargoWagon.new(quantity))
  end

  def create_passenger_wagon
    p 'Enter number of seats:'
    quantity = gets.chomp.to_i
    @trains[@train_number].engage_wagon(PassengerWagon.new(quantity))
  end

  def engage_wagon
    if @trains.empty?
      p 'Trains is absent'
    else
      show_trains
      p 'Choose train number'
      @train_number = gets.chomp.to_i - 1
      if @trains[@train_number].type == 'cargo' then create_cargo_wagon
      else create_passenger_wagon
      end
    end
  end

  def choose_dsng_wgn
    train_number = gets.chomp.to_i - 1
    type = @trains[train_number].type
    case type
    when 'cargo'
      @trains[train_number].disengage_wagon(CargoWagon.new)
    when 'passenger'
      @trains[train_number].disengage_wagon(PassengerWagon.new)
    end
  end

  def disengage_wagon
    if @trains.empty?
      p 'Trains is absent'
    else
      show_trains
      p 'Choose train number'
      choose_dsng_wgn
    end
  end

  def loadining_wagon
    p 'Enter your volume'
    volume = gets.chomp.to_i
    @trains[@num_of_train].wagons[@num_of_wagon].loading(volume)
    p 'Volume entered'
  end

  def take_seat
    @trains[@num_of_train].wagons[@num_of_wagon].take_seat
    p 'Seat was taken by passenger'
  end

  def choosing_train
    p 'Choose train:'
    show_trains
    @num_of_train = gets.chomp.to_i - 1
  end

  def choosing_wagon
    if @trains[@num_of_train].wagons.any?
      p "Train has #{@trains[@num_of_train].wagons.count} wagon(s). Choose num:"
      @num_of_wagon = gets.chomp.to_i - 1
    else
      p 'Train has no wagons'
    end
  end

  def manage_wagon
    choosing_train
    choosing_wagon
    if @trains[@num_of_train].type == 'cargo' then loadining_wagon
    else take_seat
    end
  end

  def forward
    if @trains.empty?
      p 'Trains is absent'
    else
      show_trains
      p 'Choose train number '
      train_number = gets.chomp.to_i - 1
      @trains[train_number].move_to_next
    end
  end

  def backward
    if @trains.empty?
      p 'Trains is absent'
    else
      show_trains
      p 'Choose train number '
      train_number = gets.chomp.to_i - 1
      @trains[train_number].move_back
    end
  end

  def trains_on_station
    if @stations.empty?
      p 'Stations list is empty'
    else
      show_stations
      p 'Choose station number '
      station_num = gets.chomp.to_i - 1
      @stations[station_num].trains.each { |train| p "Train #{train.number}" }
    end
  end

  def show_wagon(wagon, train)
    if wagon.type == 'passenger'
      p "Nuber of wagon: #{train.wagons.index(wagon) + 1}, wagon type: #{wagon.type}, free seats: #{wagon.show_free_seats}, taken seats: #{wagon.taken}"
    else
      p "Nuber of wagon: #{train.wagons.index(wagon) + 1}, wagon type: #{wagon.type}, free volume: #{wagon.show_volume_left}, taken volume: #{wagon.show_taken_volume}"
    end
  end

  def all_stations_and_trains
    @stations.each do |station|
      p "Station name: #{station.name}"
      station.each_train do |train|
        p "Number: #{train.number}, type: #{train.type}, wagons: #{train.wagons.count}"
        train.each_wagon do |wagon|
          show_wagon(wagon, train)
        end
      end
    end
  end
end
Base.new.run
