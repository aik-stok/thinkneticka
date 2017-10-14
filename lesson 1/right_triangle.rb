p "Please enter length of all triangle sides"
p "Side A:"
side_a = Float(gets.chomp)
p "Side B:"
side_b = Float(gets.chomp)
p "Side C:"
side_c = Float(gets.chomp)

a,b,c = [side_a,side_b,side_c].sort

if a**2 + b**2 == c**2
  p "Right Triangle"
elsif a**2 + b**2 == c**2 && a == b
  p"Isosceles Right Triangle"
elsif a == b && a == c && b == c
  p "Equilateral Triangle"
elsif a == b || a == c || b == c
  p "Isosceles Triangle"
end
