# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'accessors.rb'
require_relative 'validation.rb'
class Bank
  TRAIN_TYPES = [PassengerTrain, CargoTrain].freeze

  attr_reader :stations, :trains, :routes
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def create_station(name)
    stations.push Station.new(name)
  end

  def train_types
    TRAIN_TYPES
  end

  def create_train(train_number, train_type)
    train_class = TRAIN_TYPES[train_type]
    trains.push train_class.new(train_number)
  end

  def create_route(start_station, terminal_station)
    routes.push Route.new(stations[start_station], stations[terminal_station])
  end

  def assign_route(train_number, route_number)
    trains[train_number].accept_route(routes[route_number])
  end

  def add_wagons(train_number, capacity)
    train = trains[train_number]
    wagon = if train.instance_of?(PassengerTrain)
              PassengerWagon.new(capacity)
            else
              CargoWagon.new(capacity)
            end
    train.hitching(wagon)
  end

  def delete_wagons(train_number, wagon_number)
    train = trains[train_number]
    train.unhitching(train.wagons[wagon_number])
  end

  def move_forward(train_number)
    trains[train_number].go_forward
  end

  def move_back(train_number)
    trains[train_number].go_back
  end

  def plus_station(route_number, station_number)
    routes[route_number].add_station(stations[station_number])
  end

  def minus_station(route_number, station_number)
    routes[route_number].delete_station(stations[station_number])
  end

  def train?(train_number)
    trains.find { |t| t.number == train_number }
  end

  def station?(station_name)
    stations.find { |s| s.name == station_name }
  end

  def wrong_train_type?(train_type)
    train_types[train_type].nil?
  end

  def wrong_station?(station_number)
    stations[station_number].nil?
  end

  def wrong_route?(route_number)
    routes[route_number].nil?
  end

  def wrong_wagon?(train_num, wagon_number)
    trains[train_num].wagons[wagon_number].nil?
  end

  def wrong_train?(train_number)
    trains[train_number].nil?
  end

  def correct_station(station_number)
    if stations[station_number].nil?
      puts 'There is no such station'
      false
    else
      true
    end
  end

  def correct_route(route_number)
    if routes[route_number].nil?
      puts 'There is no such route'
      false
    else
      true
    end
  end

  def correct_wagon(train_number, wagon_number)
    if trains[train_number].wagons[wagon_number].nil?
      puts 'There is no such wagon'
      false
    else
      true
    end
  end

  def correct_train(train_number)
    if trains[train_number].nil?
      puts 'There is no such train'
      false
    else
      true
    end
  end
end
