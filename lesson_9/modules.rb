module Acessors
  def setter_end_history(name, var_name)
    define_method("#{name}=".to_sym) do |value|
      instance_variable_set(var_name, value)
      @history ||= {}
      @history["@#{name}"].nil? ? @history["@#{name}"] = [value] : @history["@#{name}"] << value
    end
  end

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      setter_end_history(name, var_name)
      define_method("#{name}_history") { instance_variable_get(:@history)["@#{name}"] }
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
      @validations << [name, validation_type, other]
    end
  end

  module InstanceMethods
    def presence?(name)
      raise 'Empty' if instance_variable_get(name).nil? || name.to_s.empty?
      true
    end

    def format?(name, pattern)
      raise 'Wrong format' if instance_variable_get(name) !~ pattern
      true
    end

    def type?(name, other)
      instance_variable_get(name).is_a?(other) ? true : (raise 'Wrong type of object')
    end

    def validate!
      self.class.validations.each do |arr|
        case arr[1]
        when :presence then presence?("@#{arr[0]}")
        when :format then format?("@#{arr[0]}", arr[2])
        when :type then type?("@#{arr[0]}", arr[2])
        end
      end
      true
    end

    def valid?
      validate!
    rescue => e
      e.message
      false
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
