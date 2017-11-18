class CargoWagon < Wagon

  attr_reader :type, :hold_capacity
  
  def initialize(capacity = 22)
    @type = "cargo"
    @hold_capacity = capacity
    @volume_taken = 0
  end
  
  def loading(meters)
    unless @volume_taken + meters > @hold_capacity
      @volume_taken += meters
    else
      p "Overload!"
    end
  end
  
  def show_taken_volume
    @volume_taken
  end
  
  def show_volume_left
    @hold_capacity - @volume_taken
  end

end