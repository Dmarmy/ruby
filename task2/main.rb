# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'station'
require_relative 'route'
require_relative 'interface'
require_relative 'bank'

bank = Bank.new

interface = Interface.new(bank)

interface.start
