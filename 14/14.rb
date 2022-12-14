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
  while !occupied_spaces.include? (x, y = [500, 0]) do
    while (offset = [0, -1, 1].find { |offset| !occupied_spaces.include?([x + offset, y + 1]) }) do

      if y + 1 == boundry
        break if include_floor
        return units
      end

      x, y = [x + offset, y + 1]
    end
    occupied_spaces << [x, y]
    units += 1
  end
  units
end

puts fill_sand(occupied_spaces.dup)
puts fill_sand(occupied_spaces.dup, include_floor: true)