# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(*args)
      @validations ||= []
      @validations << args
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        send(validation[1], instance_variable_get("@#{validation[0]}"),
             validation[2])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def presence(var, *)
      raise 'Cant be empty' if var.to_s.empty?
    end

    def format(var, exp)
      raise 'Wrong format ' if var.to_s !~ exp
    end

    def type(var, type)
      raise 'Wrong type' unless var.is_a? type
    end
  end
end
