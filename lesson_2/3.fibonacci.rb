sum = 0
arr = [0,1]

loop do
  sum =(arr[-1] + arr[-2])
  break if sum > 100
  arr << sum
end
p arr
