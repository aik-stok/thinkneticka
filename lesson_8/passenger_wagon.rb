class PassengerWagon < Wagon
  attr_reader :type, :seats, :taken

  def initialize(seats_quant = 22)
    @type = 'passenger'
    @seats = seats_quant
    @taken = 0
  end

  def take_seat
    if @taken + 1 > @seats
      p 'No more free seats'
    else
      @taken += 1
    end
  end

  def show_taken_seats
    @taken
  end

  def show_free_seats
    @seats - @taken
  end
end
