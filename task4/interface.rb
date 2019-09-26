# frozen_string_literal: true

require_relative 'bank'
class Interface
  def initialize(bank)
    @bank = bank
  end

  OPTIONS = ['Create station', 'Create train', 'Create route',
             'Assign train route ', 'Add wagon',
             'Delete wagon', 'Move train forward',
             'Move train back ', 'Show stations list',
             'Show trains at station', 'Add station',
             'Delete station', 'Exit'].freeze

  def start
    loop do
      OPTIONS.each_with_index do |value, index|
        puts "#{index + 1} : #{value} "
      end
      puts 'Enter index'
      choice = gets.to_i
      puts "Now we are going to #{OPTIONS[choice - 1]}"
      case choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        assign_route
      when 5
        add_wagons
      when 6
        delete_wagons
      when 7
        move_forward
      when 8
        move_back
      when 9
        show_stations
      when 10
        show_trains_at_station
      when 11
        plus_station
      when 12
        minus_station
      when 13
        break
      end
    end
  end

  private

  attr_reader :bank
  def create_station
    puts 'Enter station name'
    station_name = gets.chomp
    raise 'Already exists' if bank.station?(station_name)

    bank.create_station(station_name)
  rescue RuntimeError => e
    puts e.message
  end

  def create_train
    puts 'Enter train number'
    train_number = gets.chomp
    raise 'Already exists' if bank.train?(train_number)

    puts 'Enter 0 for passenger train or 1 for cargo train'
    train_type = gets.to_i
    raise 'Wrong train type' if bank.wrong_train_type?(train_type)

    bank.create_train(train_number, train_type)
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    raise 'Create more stations' if bank.stations.size < 2

    first_station = choose_item(bank.stations, 'Choose first station: ')
    raise 'There is no such station' unless bank.correct_station(first_station)

    last_station = choose_item(bank.stations, 'Choose last station: ')
    raise 'There is no such station' unless bank.correct_station(last_station)

    raise 'Stations should be different' if first_station == last_station

    bank.create_route(first_station, last_station)
  rescue RuntimeError => e
    puts e.message
  end

  def assign_route
    train_number = choose_item(bank.trains, 'Choose train: ')
    raise 'There is no such train' unless bank.correct_train(train_number)

    route_number = choose_item(bank.routes, 'Choose route: ')
    bank.assign_route(train_number, route_number)
    raise 'There is no such route' unless bank.correct_route(route_number)
  rescue RuntimeError => e
    puts e.message
  end

  def add_wagons
    train_number = choose_item(bank.trains, 'Choose train: ')
    raise 'There is no such train' unless bank.correct_train(train_number)

    bank.add_wagons(train_number)
  rescue RuntimeError => e
    puts e.message
  end

  def delete_wagons
    train_number = choose_item(bank.trains, 'Choose train: ')
    raise 'There is no such train' unless bank.correct_train(train_number)

    wagon_number = choose_item(bank.trains[train_number].wagons, 'Choose wagon')
    bank.delete_wagons(train_number, wagon_number)
  rescue RuntimeError => e
    puts e.message
  end

  def move_forward
    train_number = choose_item(bank.trains, 'Choose train')
    raise 'There is no such train' unless bank.correct_train(train_number)

    bank.move_forward(train_number)
  rescue RuntimeError => e
    puts e.message
  end

  def move_back
    train_number = choose_item(bank.trains, 'Choose train')
    raise 'There is no such train' unless bank.correct_train(train_number)

    bank.move_back(train_number)
  rescue RuntimeError => e
    puts e.message
  end

  def show_stations
    view_collection(bank.stations)
  end

  def show_trains_at_station
    station_number = choose_item(bank.stations, 'Choose station')
    raise 'There is no such station' unless bank.correct_station(station_number)

    station = bank.stations[station_number]
    puts "Trains at  #{station.name}: "
    view_collection(station.trains)
  rescue RuntimeError => e
    puts e.message
  end

  def plus_station
    route_number = choose_item(bank.routes, 'Choose route')
    raise 'There is no such route' unless bank.correct_route(route_number)

    station_number = choose_item(bank.stations, 'Choose station')
    raise 'There is no such station' unless bank.correct_station(station_number)

    bank.plus_station(route_number, station_number)
  rescue RuntimeError => e
    puts e.message
  end

  def minus_station
    route_number = choose_item(bank.routes, 'Choose route')
    raise 'There is no such route' unless bank.correct_route(route_number)

    station_number = choose_item(bank.stations, 'Choose station')
    raise 'There is no such station' unless bank.correct_station(station_number)

    bank.minus_station(route_number, station_number)
  rescue RuntimeError => e
    puts e.message
  end

  def view_collection(collection)
    collection.each.with_index(1) do |item, index|
      puts "#{index}. #{item}\n"
    end
  end

  def choose_item(collection, display_message)
    puts display_message
    view_collection(collection)
    item_number = gets.to_i - 1
  end
end
