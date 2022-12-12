state, steps = File.read('input.txt').split(/^\n/)
state_array = state.each_line.map { |line| line.scan(/[ \[](?: |(\w))[ \]] ?/).flatten }.transpose.map(&:compact)

new_states = steps.each_line.each_with_object([state_array.map(&:dup), state_array.map(&:dup)]) do |step_string, (state_1, state_2)|
  step = step_string.scan(/(\d+)/).flatten.map(&:to_i)
  step[0].times { state_1[step[2].to_i - 1].unshift(state_1[step[1].to_i - 1].shift) }
  state_2[step[2] - 1].unshift(*state_2[step[1] - 1].shift(step[0]))
end

puts new_states[0].map(&:first).join
puts new_states[1].map(&:first).join