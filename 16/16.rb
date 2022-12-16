class Cave
  REGEX = /Valve (?<valve>\w+).+?(?<rate>\d+);.+?valves? (?<connected>.+)/

  def initialize(positions:)
    @valves = File.readlines('input.txt').each_with_object({}) do |line, valves|
      params = line.match(REGEX).named_captures

      valves[params['valve']] = { rate: params['rate'].to_i, connected_valves: params['connected'].strip.split(', ') }
    end

    @states = [{
      positions:         positions,
      available_valves:  working_valves,
      pressure_released: 0
    }]
  end

  def get_max_pressure_released
    overall_max_pressure = 0
    max_pressure_for_valve_combinations = Hash.new(0)

    until @states.empty?
      state = @states.shift

      get_next_states(state).each do |next_state|
        state_key = [next_state[:available_valves], next_state[:positions].map { |position| position[:valve] }]
        if next_state[:pressure_released] > max_pressure_for_valve_combinations[state_key]
          max_pressure_for_valve_combinations[state_key] = next_state[:pressure_released]
          overall_max_pressure = [overall_max_pressure, next_state[:pressure_released]].max
          @states << next_state
        end
      end
    end

    overall_max_pressure
  end

  private
    def valve_routes
      @valve_routes ||= @valves.keys.each_with_object({}) do |valve, routes|
        routes[valve] = {}
        possible_routes = [{ valve: valve, path: [] }]

        until possible_routes.empty? do
          route = possible_routes.shift
          unless routes[valve].key?(route[:valve])
            routes[valve][route[:valve]] = route[:path] unless route[:path].empty?

            @valves[route[:valve]][:connected_valves].each do |next_valve|
              possible_routes << { valve: next_valve, path: [*route[:path], next_valve] }
            end
          end
        end
      end
    end

    def travel_time(from:, to:)
      valve_routes[from][to].size
    end

    def working_valves
      @working_valves ||= @valves.keys.select { |valve| @valves[valve][:rate] > 0 }
    end

    def get_next_states(state)
      new_states = []
      state[:positions].each_with_index do |position, index|
        state[:available_valves].each do |valve|
          new_time_available = position[:time_available] - travel_time(from: position[:valve], to: valve) - 1

          if new_time_available > 0
            new_positions = state[:positions].dup
            new_positions[index] = { valve: valve, time_available: new_time_available }

            new_states << {
              positions:         new_positions,
              available_valves:  state[:available_valves] - [valve],
              pressure_released: @valves[valve][:rate] * new_time_available + state[:pressure_released]
            }
          end
        end
      end

      new_states
    end
end

puts Cave.new(positions: [{ valve: 'AA', time_available: 30 }]).get_max_pressure_released
puts Cave.new(positions: [{ valve: 'AA', time_available: 26 }, { valve: 'AA', time_available: 26 }]).get_max_pressure_released