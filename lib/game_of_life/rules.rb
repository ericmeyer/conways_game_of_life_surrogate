module GameOfLife
  class Rules
    def self.should_live_in_next_generation?(cell)
      case cell.number_of_living_neighbors
      when 2
        cell.is_alive
      when 3
        true
      else
        false
      end
    end
  end
end