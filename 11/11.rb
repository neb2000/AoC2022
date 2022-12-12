require 'ostruct'
REGEX = /.+: (?<items>(?:\d+(?:, )?)+).+= (?<formula>.+?)\n.+?(?<div>\d+)\n.+?(?<t>\d+)\n.+?(?<f>\d+)/m

class Monkey < OpenStruct
  def round(include_divider: true)
    items.size.times do
      self.inspect_count += 1
      new_item = if include_divider
        new_worry_level(items.shift) / 3
      else
        new_worry_level(items.shift) % self.class.least_common_multiple
      end

      self.class.monkeys[(new_item % div) == 0 ? t : f].items << new_item
    end
  end

  def new_worry_level(old)
    eval formula
  end

  def self.least_common_multiple
    @least_common_multiple ||= monkeys.map(&:div).inject(:lcm)
  end

  def self.monkeys
    @monkeys
  end

  def self.add_monkey(params)
    @monkeys ||= []
    @monkeys << new(
      items:         params['items'].split(/, /).map(&:to_i),
      formula:       params['formula'],
      div:           params['div'].to_i,
      t:             params['t'].to_i,
      f:             params['f'].to_i,
      inspect_count: 0
    )
  end
end

File.read('input.txt').split(/^\n/).each do |text|
  Monkey.add_monkey(text.match(REGEX).named_captures)
end

# 20.times { Monkey.monkeys.each(&:round) }
# puts Monkey.monkeys.map(&:inspect_count).max(2).inject(:*)

10_000.times { Monkey.monkeys.each { |monkey| monkey.round(include_divider: false) } }
puts Monkey.monkeys.map(&:inspect_count).max(2).inject(:*)
