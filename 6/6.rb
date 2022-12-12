def get_position(length)
  match = (0..(data = File.read('input.txt').chars).size).find do |index|
    data[index, length].uniq.size == length
  end
  match + length
end

puts get_position(4)
puts get_position(14)