PRIOIRITIES = Hash[(('a'..'z').to_a + ('A'..'Z').to_a).each.with_index(1).to_a]

priorities = File.readlines('input.txt').sum do |line|
  compartments = line.chars.each_slice(line.size / 2).to_a
  PRIOIRITIES[(compartments[0] & compartments[1])[0]]
end
puts priorities

priorities = File.readlines('input.txt').each_slice(3).sum do |group|
  PRIOIRITIES[(group[0].chars & group[1].chars & group[2].chars)[0]]
end
puts priorities