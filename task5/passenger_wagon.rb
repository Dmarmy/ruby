# frozen_string_literal: true

require_relative 'wagon'
class PassengerWagon < Wagon
  def take_volume
    super(1)
  end
  def to_s
    "Type: passenger. Volume: free #{free_volume}, busy #{busy_volume}"
  end
end
