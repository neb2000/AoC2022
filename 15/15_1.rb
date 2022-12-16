require 'set'
covered_x = []
beacon_x = Set.new

target_row = 2_000_000

File.foreach('input.txt').each do |line|
  sx, sy, bx, by = line.scan(/(-?\d+)/).map { |match| match[0].to_i }

  x_coverage = (sx - bx).abs + (sy - by).abs - (sy - target_row).abs

  covered_x << ((sx - x_coverage)..(sx + x_coverage)) if x_coverage > 0

  beacon_x << bx if by == target_row
end

puts covered_x.map(&:to_a).flatten.uniq.size - beacon_x.size
