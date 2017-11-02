class Station
  attr_reader :name, :trains
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train
  end

  def quantity_of_type(word_type)
    trains.count {|train| train.type == word_type}
  end

  def depart(train)
    trains.delete(train)
  end
end


