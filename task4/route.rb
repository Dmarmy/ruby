# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
class Route
  include InstanceCounter
  include Validation

  attr_accessor :stations

  def initialize(start_station, terminal_station)
    @stations = [start_station, terminal_station]
    register_instance
    validate!
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

  protected

  def validate!
    raise 'First station is not an instance of Station class' unless stations.first.is_a?(Station)
    raise 'Last station is not an instance of Station class' unless stations.last.is_a?(Station)
    raise 'Stations should be different' if stations.first == stations.last
  end
end
