require 'set'
count_1, count_2 = [0, 0]

File.readlines('input.txt').each do |line|
  elf1, elf2 = line.split(',').map do |elf|
    start, finish = elf.split('-').map(&:to_i)
    (start..finish).to_set
  end
  count_1 += 1 if elf2.subset?(elf1) || elf1.subset?(elf2)
  count_2 += 1 if elf1.intersection(elf2).any?
end

puts count_1
puts count_2