# frozen_string_literal: true

require_relative 'passenger_wagon'
require_relative 'train'
class PassengerTrain < Train
  def wagon_class
    PassengerWagon
  end
end
