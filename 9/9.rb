DIRECTIONS = { 'U' => [1, -1], 'D' => [1, 1], 'L' => [0, -1], 'R' => [0, 1] }

def tails_positions_count(knots_size)
  tail_positions = []
  knots = Array.new(knots_size + 1) { [0, 0] }

  File.read('input.txt').each_line do |line|
    direction, steps = line.split
    steps.to_i.times do
      knots[0][DIRECTIONS[direction][0]] += DIRECTIONS[direction][1]

      (knots.size - 1).times do |index|
        current_knot, next_knot = knots.slice(index, 2)
        if (current_knot[0] - next_knot[0]).abs > 1 || (current_knot[1] - next_knot[1]).abs > 1
          next_knot[0] += current_knot[0] <=> next_knot[0]
          next_knot[1] += current_knot[1] <=> next_knot[1]
        end
      end

      tail_positions << knots[-1].dup
    end
  end
  tail_positions.uniq.size
end

puts tails_positions_count(1)
puts tails_positions_count(9)