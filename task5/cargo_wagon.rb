# frozen_string_literal: true

require_relative 'wagon'
class CargoWagon < Wagon

  def to_s
    "Type: cargo. Volume: free #{free_volume}, busy #{busy_volume}"
  end
end
