require_relative "route"
require_relative "station"
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "cargo_wagon"
require_relative "passenger_wagon"

@stations = []
@trains = []
@routes =[]
@wagons = []

def show_trains
  @trains.each_with_index {|train, index| p "#{index+1}. #{train.number}"}
end

def show_routes
  @routes.each_with_index {|route, index| p "#{index+1}. #{route}"}
end

def show_stations
  @stations.each_with_index {|station, index| p "#{index+1}. #{station.name}"}
end

loop do
  print " 
   Put number of paragraph:
  1 Create stations
  2 Create trains
  3 Creatre route and manage stations
  4 Assign route to train
  5 Engage wagons
  6 Disengage wagons
  7 Move train to next station
  8 Move train to previous station
  9 Show stations and list of trains
 "

  answer = gets.chomp.to_i
  
  case answer
    when 1
      p "Name your station"
      st_name = gets.chomp.to_s
      @stations << Station.new(st_name)
    when 2
      p "Type of train: 1 - pass, 2 - cargo"
      tr_type = gets.chomp.to_i
      p "Enter train number"
      tr_number = gets.chomp.to_i
      tr_type == 1 ? @trains << PassengerTrain.new(tr_number) : @trains << CargoTrain.new(tr_number)
    when 3
      p "'add' - add new route, 'manage' - manage existing"
      answer = gets.chomp
      case answer
        when "add"
          unless @stations.empty?
            p "Chose two stations from the list"
            show_stations
            p "Enter number of first station"
            first_st = gets.chomp.to_i - 1
            p "Enter number of first station"
            last_st = gets.chomp.to_i - 1
            @routes << Route.new(@stations[first_st], @stations[last_st])
            p "Route created"
          else
            p "No stations to create route"
          end
        when "manage"
          unless @routes.empty?
            p "Chose route from the list of routes: "
            show_routes
            route_index = gets.chomp.to_i - 1
            p "1 - add station, 2 - remove station"
            answer = gets.chomp.to_i
            show_stations
            if answer == 1
              p "Enter number of station to add" && answer = gets.chomp.to_i - 1
                @routes[route_index].add_station(@stations[answer])
            elsif answer == 2
              p "Enter number of station to remove" && answer = gets.chomp.to_i - 1
                @routes[route_index].delete_station(@stations[answer])
            end
          else
            p "No existing routes"
          end
      end

    when 4
      unless @trains.empty? || @routes.empty?
        p "Enter train index: "
        show_trains
        train_index = gets.chomp.to_i - 1
        p "Choose route number:"
        show_routes
        route_index = gets.chomp.to_i - 1
        @trains[train_index].get_route(@routes[route_index])
        p "Route assigned"
      else
        p "Trains or route is absent"
      end
    when 5
      unless @trains.empty?
        show_trains
        p "Choose train number"
        train_number = gets.chomp.to_i - 1
        type = @trains[train_number].type
        type == "cargo" ? @trains[train_number].engage_wagon(CargoWagon.new) : @trains[train_number].engage_wagon(PassengerWagon.new)
      else
        p "Trains is absent"
      end
    when 6
      unless @trains.empty?
        show_trains
        p "Choose train number"
        train_number = gets.chomp.to_i - 1
        @trains[train_number].disengage_wagon
      else
        p "Trains is absent"
      end
    when 7
      unless @trains.empty?
        show_trains
        p "Choose train number "
        train_number = gets.chomp.to_i - 1
        @trains[train_number].move_to_next
      else
        p "Trains is absent"
      end
    when 8
      unless @trains.empty?
        show_trains
        p "Choose train number "
        train_number = gets.chomp.to_i - 1
        @trains[train_number].move_back
      else
        p "Trains is absent"
      end
    when 9
      unless @stations.empty?
      show_stations
        p "Choose station number "
        station_number = gets.chomp.to_i - 1
        @stations[station_number].trains.each {|train| p "Number #{train.number}"}
      else
        p "Stations list is empty"
      end
    when 10
      break
    end
end  