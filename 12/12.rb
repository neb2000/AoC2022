require 'set'
class Grid
  HEIGHT_MAP = Hash[[['S', 0], ['E', 25], *('a'..'z').each_with_index.to_a]]

  def initialize
    @map = File.readlines('input.txt').map { |line| line.strip.chars }
    @height = @map.size
    @width = @map[0].size
    @grid = (0..@height - 1).to_a.product((0..@width - 1).to_a)
  end

  def start_position
    @start_position ||= @grid.find { |(row, col)| @map[row][col] == 'S' }
  end

  def all_lowest_positions
    @all_lowest_positions ||= @grid.select { |(row, col)| HEIGHT_MAP[@map[row][col]] == 0 }
  end

  def end_position
    @end_position ||= @grid.find { |(row, col)| @map[row][col] == 'E' }
  end

  def possible_next_steps(row, col)
    [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]].select do |(new_row, new_col)|
      (new_row >= 0 && new_row < @height && new_col >= 0 && new_col < @width) &&
      (HEIGHT_MAP[@map[new_row][new_col]] - HEIGHT_MAP[@map[row][col]] <= 1)
    end
  end

  def find_path(start_positions = [start_position])
    possible_routes = start_positions.map { |position| { position: position, steps: 0 } }
    visited_positions = Set.new(start_positions)

    while possible_routes.size > 0 do
      route = possible_routes.shift
      possible_next_steps(*route[:position]).each do |next_step|
        unless visited_positions.include?(next_step)
          return route[:steps] + 1 if next_step == end_position

          possible_routes << { position: next_step, steps: route[:steps] + 1 }
          visited_positions << next_step
        end
      end
    end
  end
end

grid = Grid.new
puts grid.find_path
puts grid.find_path(grid.all_lowest_positions)