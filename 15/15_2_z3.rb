require 'z3'

MAX_RANGE = 4_000_000

x = Z3.Int('x')
y = Z3.Int('y')
solver = Z3::Solver.new

solver.assert(x >= 0)
solver.assert(x <= MAX_RANGE)
solver.assert(y >= 0)
solver.assert(y <= MAX_RANGE)

def z3abs(x)
  Z3.IfThenElse(x >= 0, x, -x)
end

File.readlines('input.txt').each do |line|
  sx, sy, bx, by = line.scan(/(-?\d+)/).map { |match| match[0].to_i }
  distance = (sx - bx).abs + (sy - by).abs

  solver.assert(z3abs(sx - x) + z3abs(sy - y) > distance)
end

solver.check
model = solver.model
puts model[x].to_i * 4_000_000 + model[y].to_i