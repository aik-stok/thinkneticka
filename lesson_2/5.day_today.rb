p "Please, input dayte (d, m, yyyy)"
p "Day : "
@day = gets.chomp.to_i
p "Month : "
@month = gets.chomp.to_i - 1
p "Year : "
year = gets.chomp.to_i

COMMON_YEAR = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
LEAP_YEAR = [nil, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
def m_calc(year_t)
sum = 0
  year_t[1..@month].each {|m| sum += m}
  sum += @day
  p "#{sum} day"
end
if year % 4 == 0 && year % 100 != 0 
  p "Leap"
  m_calc(LEAP_YEAR)
elsif year % 400 == 0 
  p "Leap"
  m_calc(LEAP_YEAR)
else 
  p "Common"
  m_calc(COMMON_YEAR)
end