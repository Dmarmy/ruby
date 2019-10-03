# frozen_string_literal: true

require_relative 'company'
class Wagon
  include Company
  attr_reader :total_volume, :free_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @free_volume = total_volume
  end

  def take_volume(volume)
    raise 'Not enough space' if (@free_volume - volume).negative?

    @free_volume -= volume
  end

  def busy_volume
    @total_volume - @free_volume
  end


end
