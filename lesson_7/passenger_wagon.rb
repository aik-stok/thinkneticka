class PassengerWagon < Wagon

  attr_reader :type, :seats
  
  def initialize(seats_quant = 22)
    @type = "passenger"
    @seats = seats_quant
    @taken = 0
  end
  
  def take_seat
    unless @taken + 1 > @seats
      @taken += 1
    else
      p "No more free seats"
    end
  end
  
  def show_taken_seats
    @taken
  end
  
  def show_free_seats
    @seats - @taken
  end
    
end