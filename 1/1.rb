calories = File.read('input.txt').split(/^\n/).map { |elf| elf.each_line.map(&:to_i).sum }

puts calories.max
puts calories.max(3).sum