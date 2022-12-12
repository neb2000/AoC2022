ROCK, PAPER, SCISSORS = [1, 2, 3]
WIN, DRAW, LOSE       = [6, 3, 0]

ELF_MAP = { 'A' => ROCK, 'B' => PAPER, 'C' => SCISSORS }
SCORES = { ROCK => { ROCK => DRAW, PAPER => LOSE, SCISSORS => WIN }, PAPER => { ROCK => WIN, PAPER => DRAW, SCISSORS => LOSE }, SCISSORS => { ROCK => LOSE, PAPER => WIN, SCISSORS => DRAW } }

PART_1_OWN_MAP = { 'X' => ROCK, 'Y' => PAPER, 'Z' => SCISSORS }
part_one_own = -> (elf, own) do
  PART_1_OWN_MAP[own]
end

PART_2_OWN_MAP = { 'X' => { ROCK => PAPER, PAPER => SCISSORS, SCISSORS => ROCK, }, 'Y' => { ROCK => ROCK, PAPER => PAPER, SCISSORS => SCISSORS, }, 'Z' => { ROCK => SCISSORS, PAPER => ROCK, SCISSORS => PAPER, } }
part_two_own = -> (elf, own) do
  PART_2_OWN_MAP[own][ELF_MAP[elf]]
end

def outcome(elf, own)
  SCORES[elf][own] + own
end

def scores(own_map)
  File.readlines('input.txt').sum do |game|
    elf, own = game.split(' ')

    outcome(ELF_MAP[elf], own_map.call(elf, own))
  end
end

puts scores(part_one_own)
puts scores(part_two_own)