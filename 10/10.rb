signals = [1]

File.readlines('input.txt').inject(1) do |x, line|
  signals << x
  signals << (x += $1.to_i) if line =~ / (\-?\d+)$/
  x
end

puts (20..220).step(40).sum { |cycle| cycle * signals[cycle - 1] }

6.times do |row|
  puts 40.times.map { |col| (signals[row * 40 + col] - col).abs <= 1 ? "#" : ' ' }.join
end