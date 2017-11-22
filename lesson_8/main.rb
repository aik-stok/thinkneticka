require_relative 'modules'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Base
  attr_reader :stations

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end
  
METHODS = {
    1 => add_station, 2 => add_train, 3 => manage_routes, 4 => assign_route, 5 => engage_wagon, 6 => disengage_wagon,
    7 => manage_wagon, 8 => forward, 9 => backward, 10 => trains_on_station, 11 => all_stations_and_trains
    }

  def run
    
    loop do
      print "
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
     "

      answer = gets.chomp.to_i
      menu(answer)
    end
  end

  def menu(answer)
    METHODS[answer] || "Wrong input"
  end

  private 

  def show_trains
    @trains.each_with_index { |train, index| p "#{index + 1}. #{train.number}" }
  end

  def show_routes
    @routes.each_with_index { |route, index| p "#{index + 1}. #{route}" }
  end

  def show_stations
    @stations.each_with_index { |station, index| p "#{index + 1}. #{station.name}" }
  end

  def add_station
    p 'Name your station'
    st_name = gets.chomp.to_s
    @stations << Station.new(st_name)
  end

  def add_train
    p 'Type of train: 1 - pass, 2 - cargo'
    tr_type = gets.chomp.to_i
    p 'Enter train number:'
    tr_number = gets.chomp.to_s
    tr_type == 1 ? train = PassengerTrain.new(tr_number) : train = CargoTrain.new(tr_number)
    @trains << train
    p 'Train created'
  rescue RuntimeError => e
    p e.message
    retry
  end

  def manage_routes
    p "'add' - add new route, 'manage' - manage existing"
    answer = gets.chomp
    case answer
    when 'add' then add_route

    when 'manage' then manage_route

    end
  end

  def add_route
    if @stations.empty?
      p 'No stations to create route'
    else
      p 'Chose two stations from the list'
      show_stations
      p 'Enter number of first station'
      first_st = gets.chomp.to_i - 1
      p 'Enter number of last station'
      last_st = gets.chomp.to_i - 1
      @routes << Route.new(@stations[first_st], @stations[last_st])
      p 'Route created'
    end
  end

  def manage_route
    if @routes.empty?
      p 'No existing routes'
    else
      p 'Chose route from the list of routes: '
      show_routes
      route_index = gets.chomp.to_i - 1
      p '1 - add station, 2 - remove station'
      answer = gets.chomp.to_i
      show_stations
      if answer == 1
        p 'Enter number of station to add' && answer = gets.chomp.to_i - 1
        @routes[route_index].add_station(@stations[answer])
      elsif answer == 2
        p 'Enter number of station to remove' && answer = gets.chomp.to_i - 1
        @routes[route_index].delete_station(@stations[answer])
      end
    end
  end

  def assign_route
    if @trains.empty? || @routes.empty?
      p 'Trains or route is absent'
    else
      p 'Enter train index: '
      show_trains
      train_index = gets.chomp.to_i - 1
      p 'Choose route number:'
      show_routes
      route_index = gets.chomp.to_i - 1
      @trains[train_index].get_route(@routes[route_index])
      p 'Route assigned'
    end
  end

  def engage_wagon
    if @trains.empty?
      p 'Trains is absent'
    else
      show_trains
      p 'Choose train number'
      train_number = gets.chomp.to_i - 1
      type = @trains[train_number].type
      type == 'cargo' ? (p 'Enter hold capacity: ') : (p 'Enter quantity of seats: ')
      quantity = gets.chomp.to_i
      type == 'cargo' ? @trains[train_number].engage_wagon(CargoWagon.new(quantity)) : @trains[train_number].engage_wagon(PassengerWagon.new(quantity))
    end
  end

  def disengage_wagon
    if @trains.empty?
      p 'Trains is absent'
    else
      show_trains
      p 'Choose train number'
      train_number = gets.chomp.to_i - 1
      type = @trains[train_number].type
      type == 'cargo' ? @trains[train_number].disengage_wagon(CargoWagon.new) : @trains[train_number].disengage_wagon(PassengerWagon.new)
    end
  end

  def manage_wagon
    p 'Choose train:'
    @trains.each_with_index { |train, index| p "#{index + 1}. #{train.number}" }
    num_of_train = gets.chomp.to_i
    if @trains[num_of_train - 1].wagons.any?
      p "Train has #{@trains[num_of_train - 1].wagons.count} wagon(s). Choose number of managed wagon:"
      num_of_wagon = gets.chomp.to_i - 1
      if @trains[num_of_train - 1].wagons[num_of_wagon].type == 'cargo'
        p 'Enter your volume'
        volume = gets.chomp.to_i
        @trains[num_of_train - 1].wagons[num_of_wagon].loading(volume)
        p 'Volume entered'
      else
        @trains[num_of_train - 1].wagons[num_of_wagon].take_seat
        p 'Seat was taken by passenger'
      end
    else
      p 'Train has no wagons'
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
      station_number = gets.chomp.to_i - 1
      @stations[station_number].trains.each { |train| p "Number #{train.number}" }
    end
  end

  def all_stations_and_trains
    @stations.each do |station|
      p "Station name: #{station.name}"
      station.each_train do |train|
        p "Number: #{train.number}, type: #{train.type}, wagons quantity: #{train.wagons.count}"
        train.each_wagon do |wagon|
          if wagon.type == 'passenger'
            p "Nuber of wagon: #{train.wagons.index(wagon) + 1}, wagon type: #{wagon.type}, free seats: #{wagon.show_free_seats}, taken seats: #{wagon.taken_seats}"
          else
            p "Nuber of wagon: #{train.wagons.index(wagon) + 1}, wagon type: #{wagon.type}, free volume: #{wagon.show_volume_left}, taken volume: #{wagon.show_taken_volume}"
          end
        end
      end
    end
  end

end
Base.new.run
