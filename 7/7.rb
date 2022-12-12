sizes, _ = File.read('input.txt').each_line.with_object([Hash.new(0), []]) do |line, (sizes, dirs)|
  if line =~ /^\$ cd (.+)$/
    $1 == '..' ? dirs.pop : dirs.push($1)
  elsif line =~ /^(\d+)/
    (1..dirs.size).each { |length| sizes[dirs.slice(0, length).join('/')] += $1.to_i }
  end
end

puts sizes.values.select { |v| v <= 100000 }.sum
puts sizes.values.sort.find { |v| v >= sizes['/'] - 40000000 }