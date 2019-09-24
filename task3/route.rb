# frozen_string_literal: true

require_relative 'instance_counter'
class Route
  include InstanceCounter

  attr_accessor :stations

  def initialize(start_station, terminal_station)
    @stations = [start_station, terminal_station]
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    unless [stations.first, stations.last].include?(station)
      stations.delete(station)
    end
  end

  def to_s
    "#{stations[0].name} -> #{stations[-1].name}"
  end
end
