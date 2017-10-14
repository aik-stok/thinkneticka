print "What's your name?"
name = gets.chomp

print "What is your height?"
height = Integer(gets.chomp)

ideal_weight = height - 110

if ideal_weight < 0
  p "#{name} your weight is already ideal!"
else 
  p "#{name} your ideal weight is #{ideal_weight}"
end
