class Station

  attr_reader :name, :trains
  @@instances = []
  
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances << self
  end
  
  def self.all
    @@instances
  end

  def arrive(train)
    @trains << train
  end

  def depart(train)
    trains.delete(train)
  end
  
  def each_train
    @trains.each {|train| yield(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  private #not used by any class nor UI

  def quantity_of_type(word_type)
    trains.count {|train| train.type == word_type}
  end
  
  protected
  
  def validate!
    raise "No station name inputed" if name.nil?
    raise "Name is too short. At least 2 characters" if name.length < 2
    true
  end
end
