class Station

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train
  end

  def depart(train)
    trains.delete(train)
  end

  private #not used by any class nor UI

  def quantity_of_type(word_type)
    trains.count {|train| train.type == word_type}
  end
end


