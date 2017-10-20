count = 0
vowels = {}
for chr in ("a".."z")
count += 1
  if ['a','e','i','o','u'].include?(chr)
  vowels[chr] = count
  end
end
p vowels