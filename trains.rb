# frozen_string_literal: true

class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    trains.push train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def depart(train)
    trains.delete(train)
    train.station = nil
  end
end

class Route
  attr_accessor :stations

  def initialize(start_station, terminal_station)
    @stations = [start_station, terminal_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    unless [stations.first, stations.last].include?(station)
      stations.delete(station)
    end
  end
end

class Train
  attr_reader :type, :speed, :number_of_wagons

  def initialize(train_number, type, number_of_wagons)
    @train_number = train_number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def speed_pickup(value)
    self.speed += value
  end

  def speed_decrease(value)
    self.speed -= value unless (speed - value).negative?
  end

  def hitching
    self.number_of_wagons += 1 if speed.zero?
  end

  def unhitching
    self.number_of_wagons -= 1 if speed.zero? && number_of_wagons.positive?
  end

  def accept_route(route)
    @route = route
    @route.stations[0].arrival(self)
    puts @station_index
    @station_index = 0
  end

  def go_forward
    unless @station_index >= @route.stations.size - 1
      current_station.depart(self)
      next_station.arrival(self)
      @station_index += 1
    end
  end

  def go_back
    unless @station_index < 1 && @route.nil?
      current_station.depart(self)
      previous_station.arrival(self)
      @station_index -= 1
    end
  end

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1] if @station_index + 1 < @route.stations.size
  end

  def previous_station
    @route.stations[@station_index - 1] if @station_index - 1 >= 0
  end
end
