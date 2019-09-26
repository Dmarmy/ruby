# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances
  end

  module InstanceMethods
    protected

    def register_instance
      @instances ||= 0
      @instances += 1
    end
  end
end
