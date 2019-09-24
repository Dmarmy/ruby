# frozen_string_literal: true

require_relative 'company'
class Wagon
  include Company
  def to_s
    '[___]'
    end
end
