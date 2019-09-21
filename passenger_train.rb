# frozen_string_literal: true

require_relative 'passenger_wagon'
require_relative 'train'
class PassengerTrain < Train
  def able_to_hitch?(wagon)
    wagon.instance_of?(PassengerWagon)
  end

  def to_s
    "Passenger train № #{self.number}. "
  end
end
