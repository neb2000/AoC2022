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

  def self.get_worry_level(rounds: 20, include_divider: true)
    @monkeys = []
    File.read('input.txt').split(/^\n/).each do |text|
      params = text.match(REGEX).named_captures
      @monkeys << new(
        inspect_count: 0,
        items:         params['items'].split(/, /).map(&:to_i),
        formula:       params['formula'],
        div:           params['div'].to_i,
        t:             params['t'].to_i,
        f:             params['f'].to_i
      )
    end
    rounds.times { @monkeys.each { |monkey| monkey.round(include_divider: include_divider) } }
    result = @monkeys.map(&:inspect_count).max(2).inject(:*)
    @monkeys = []

    result
  end
end

puts Monkey.get_worry_level
puts Monkey.get_worry_level(rounds: 10_000, include_divider: false)
