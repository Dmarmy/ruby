# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
class Train
  include Company
  include InstanceCounter

  attr_reader :speed, :number, :wagons, :speed, :route
  @@trains = {}
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def speed_pickup(value)
    self.speed += value
  end

  def speed_decrease(value)
    self.speed -= value unless (speed - value).negative?
  end

  def hitching(wagon)
    wagons.push wagon if speed.zero?
  end

  def unhitching(wagon)
    wagons.delete(wagon) if speed.zero?
  end

  def accept_route(route)
    @route = route
    @route.stations[0].arrival(self)
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

  def wagon_class; end
end
