sensors = {}

MAX_RANGE = 4_000_000

File.readlines('input.txt').each do |line|
  sx, sy, bx, by = line.scan(/(-?\d+)/).map { |match| match[0].to_i }

  sensors[[sx, sy]] = (sx - bx).abs + (sy - by).abs
end

sensors.each do |(sx, sy), distance|
  (distance + 1).times do |y_offset|
    [
      [(sx - distance - 1) + y_offset, sy + y_offset],
      [(sx + distance + 1) - y_offset, sy + y_offset],
      [(sx - distance - 1) + y_offset, sy - y_offset],
      [(sx + distance + 1) - y_offset, sy - y_offset]
    ].each do |tile|
      if tile[0] >= 0 && tile[0] <= MAX_RANGE &&
        tile[1] >= 0 && tile[1] <= MAX_RANGE

        in_range = sensors.except([sx, sy]).any? do |(s1x, s1y), distance1|
          (tile[0] - s1x).abs + (tile[1] - s1y).abs <= distance1
        end

        unless in_range
          puts tile[0] * MAX_RANGE + tile[1]
          return
        end
      end
    end
  end
end