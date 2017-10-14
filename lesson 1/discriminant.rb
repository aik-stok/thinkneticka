p "Please enter coeficcients"
p "coeficcient A:"
a = Float(gets.chomp)
p "coeficcient B:"
b = Float(gets.chomp)
p "coeficcient C:"
c = Float(gets.chomp)

d = b**2 - 4 * a * c

if d > 0
  x1 = (-b - Math.sqrt(d)) / (2 * a)
  x2 = (-b + Math.sqrt(d)) / (2 * a)
  p "Discriminant is #{d}, minimal square root is #{x1}, maximal #{x2}"
elsif d == 0
  x1 = x2 = -(b) / (2 * a)
  p "Discriminant is #{d},  square root is #{x1}"
elsif d < 0
  p "No square roots"
end