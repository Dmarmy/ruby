# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'accessors.rb'
require_relative 'validation.rb'
class Route
  include InstanceCounter
  include Validation
  extend Accessors

  validate :start_station, :type, Station
  validate :terminal_station, :type, Station

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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
