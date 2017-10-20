vowels = %w( a e i o u )
output = {}
alphabet = ("a".."z").to_a
alphabet.each_with_index do|char, index|
  output[char] = index + 1 if vowels.include?(char)
end
p output