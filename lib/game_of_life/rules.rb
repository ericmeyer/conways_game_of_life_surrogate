module GameOfLife
  class Rules
    def self.alive_in_next_generation?(cell)
      case cell.number_of_living_neighbors
      when 2
        cell.alive?
      when 3
        true
      else
        false
      end
    end
  end
end