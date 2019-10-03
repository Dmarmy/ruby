# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :name
  NAME_FORMAT = /^[0-9A-Z]+$/i.freeze
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@all_stations.push self
    validate!
  end

  def each_train
    trains.each { |train| yield(train) } if block_given?
  end

  def arrival(train)
    trains.push train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def depart(train)
    trains.delete(train)
  end

  def to_s
    @name
  end

  protected

  def validate!
    raise 'Name has invalid format' if name !~ NAME_FORMAT
  end
end
