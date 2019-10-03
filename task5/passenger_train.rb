# frozen_string_literal: true

require_relative 'passenger_wagon'
require_relative 'train'
class PassengerTrain < Train
  def hitch(wagon)
    super if able_to_hitch?(wagon)
  end

  def to_s
    "Passenger train № #{number}. "
  end

  private

  def able_to_hitch?(wagon)
    wagon.instance_of?(PassengerWagon)
  end
end
