module Acessors

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name, var_name_history = "@#{name}".to_sym, "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_name_history) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_name_history, []) unless !!instance_variable_get(var_name_history)
        instance_variable_get(var_name_history) << value
      end
    end
  end

  def strong_attr_acessor(_name, atr_class)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        value.is_a?(atr_class) ? instance_variable_set(var_name, value) : (raise 'Type mismatch')
      end
    end
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, validation_type, other = nil)
      @validations ||= []
      @validations << { attr_name: name, validation_type: validation_type, params: other }
      p @validations
    end
  end

  module InstanceMethods

    def validate!
      self.class.validations.each do |hash|
          inst_var = instance_variable_get("@#{hash[:attr_name]}".to_sym)
          send hash[:validation_type] , inst_var, hash[:params]
      end
    end

    def valid?
      validate!
      true
    rescue => e
      p e.message
      false
    end

    private

    def presence(inst_var, *)
      raise 'Empty' if inst_var.nil? || inst_var.to_s.empty?
    end

    def format(inst_var, pattern)
      raise 'Wrong format' if inst_var !~ pattern
    end

    def type_of(inst_var, pattern)
      (raise 'Wrong type of object') unless inst_var.is_a?(pattern)
    end

  end
  
end

module Manufacturer
  attr_accessor :manufacturer_name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :count
    
    def instances
      @count ||= 0
    end
  end
  
  module InstanceMethods
    protected

    def register_instance
      self.class.count += 1
    end
  end

end
