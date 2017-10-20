arr = []
num1 = 0
num2 = 1
while num1 < 100
  arr << num1
  num1 += num2
  arr << num2
  num2 += num1
end
p arr
