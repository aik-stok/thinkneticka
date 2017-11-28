class PassengerTrain < Train
  attr_accessor_with_history :type
  validate :number, :presence
  validate :number, :format, /^[\w\d]{3}\-?[\w\d]{2}$/
  validate :type, :type, CargoTrain

  def initialize(number)
    super
    @type = self
  end
end
