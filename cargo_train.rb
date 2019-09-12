# frozen_string_literal: true

require_relative 'cargo_wagon'
require_relative 'train'
class CargoTrain < Train
  def wagon_class
    CargoWagon
  end
end
