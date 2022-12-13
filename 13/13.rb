require 'json'
signals = File.read('input.txt').split(/^\n/).map do |group|
  group.each_line.map { |line| JSON.parse(line) }
end

def compare(lft, rgt)
  if lft.is_a?(Integer) && rgt.is_a?(Integer)
    lft <=> rgt
  elsif lft.is_a?(Array) && rgt.is_a?(Array)
    [lft.size, rgt.size].min.times do |index|
      result = compare(lft[index], rgt[index])
      return result if result != 0
    end
    lft.size <=> rgt.size
  else
    compare(Array(lft), Array(rgt))
  end
end

puts signals.size.times.inject(0) { |sum, index| sum + (compare(*signals[index]) < 0 ? (index + 1) : 0) }

sorted_signals = (signals.flatten(1) + [[2], [6]]).sort { |a, b| compare(a, b) }
puts (sorted_signals.index([2]) + 1) * (sorted_signals.index([6]) + 1)