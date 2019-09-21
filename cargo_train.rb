# frozen_string_literal: true

require_relative 'cargo_wagon'
require_relative 'train'
class CargoTrain < Train
  def able_to_hitch?(wagon)
    wagon.instance_of?(CargoWagon)
  end
  def to_s
    "Cargo train № #{self.number}. "
  end
end
