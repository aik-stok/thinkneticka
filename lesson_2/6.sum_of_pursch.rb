cart = {}
loop do
  p "Please enter name of the product or 'stop' if you had enough of this BS"
  product = gets.chomp
  break if product == "stop"
  p "Please enter price "
  price = Float gets.chomp
  p "Please enter quantity"
  quantity = Integer gets.chomp
  cart[product] = {price => quantity}
end
@total = 0
cart.each do |k, v|
  print k
  v.each do |a,b|
    sum = a * b 
    @total += sum
    print " price per pcs #{a}$, quantity #{b}, total price for this product : #{sum} $"
  end
end
print " Total sum for all your purchased products: #{@total}$"