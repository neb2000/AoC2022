require 'matrix'
matrix = Matrix[*File.read('input.txt').split(/\n/).map { |line| line.chars.map(&:to_i) }]
visible_counts = matrix.row_count * 2 + matrix.column_count * 2 - 4
viewing_scores = []

(1..(matrix.row_count - 2)).each do |row|
  (1..(matrix.column_count - 2)).each do |column|
    current_height = matrix[row, column]

    trees_to_edge = [
      matrix.row(row)[..(column - 1)].reverse,
      matrix.row(row)[(column + 1)..],
      matrix.column(column)[..(row - 1)].reverse,
      matrix.column(column)[(row + 1)..]
    ]

    viewing_scores << trees_to_edge.inject(1) do |score, trees|
      tree_index = trees.index { |tree_height| tree_height >= current_height }
      score * (tree_index ? tree_index + 1 : trees.size)
    end

    visible_counts += 1 if trees_to_edge.any? { |trees| trees.max < current_height }
  end
end

puts visible_counts
puts viewing_scores.max