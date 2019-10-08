# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      var_name = "@#{attribute}".to_sym
      var_history_name = "@#{attribute}_history".to_sym

      define_method(attribute) { instance_variable_get(var_name) }
      define_method("#{attribute}_history".to_sym) { instance_variable_get(var_history_name) }

      define_method("#{attribute}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history_array = if instance_variable_defined? var_history_name
                          instance_variable_get(var_history_name)
                        else
                          instance_variable_set(var_history_name, [])
                        end
        history_array << value
      end
    end
  end

  def strong_attr_accessor(attribute, type)
    var_name = "@#{attribute}".to_sym
    define_method(attribute.to_sym) { instance_variable_get(var_name) }

    define_method("#{attribute}=".to_sym) do |value|
      raise 'Wrong class type' unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
  end
