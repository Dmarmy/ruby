# frozen_string_literal: true

require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :trains, :name

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@all_stations.push self
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
end
