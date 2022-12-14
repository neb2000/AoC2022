require 'set'
occupied_spaces = Set.new
File.foreach('input.txt') do |line|
  line.scan(/(?:(\d+),(\d+))/).map { |pair| pair.map(&:to_i) }.each_cons(2) do |pair|
    start, finish = pair.minmax
    occupied_spaces += (start[0]..finish[0]).to_a.product((start[1]..finish[1]).to_a)
  end
end

def fill_sand(occupied_spaces, include_floor: false)
  boundry = occupied_spaces.map(&:last).max + (include_floor ? 2 : 0)
  units = 0
  while !occupied_spaces.include?(sand = [500, 0]) do
    while (next_space = [
        [sand[0], sand[1] + 1], [sand[0] - 1, sand[1] + 1], [sand[0] + 1, sand[1] + 1]
      ].find { |space| !occupied_spaces.include?(space) }) do

      if next_space[1] == boundry
        break if include_floor
        return units
      end

      sand = next_space
    end
    occupied_spaces << sand
    units += 1
  end
  units
end

puts fill_sand(occupied_spaces.dup)
puts fill_sand(occupied_spaces.dup, include_floor: true)