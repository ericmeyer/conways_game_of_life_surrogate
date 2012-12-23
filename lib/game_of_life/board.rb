require "game_of_life/rules"
require "game_of_life/living_cells"

module GameOfLife
  class Board

    def initialize
      @living_cells = LivingCells.new
    end

    def bring_to_life_at(location)
      @living_cells.bring_to_life_at location
    end

    def has_living_cell_at?(location)
      @living_cells.has_living_cell_at? location
    end

    def has_any_living_cells?
      @living_cells.has_any_living_cells?
    end

    def advance_generation
      next_generation = LivingCells.new
      @living_cells.each_potential_living_cell do |cell|
        next_generation.bring_to_life_at(cell.location) if Rules.alive_in_next_generation?(cell)
      end
      @living_cells = next_generation
    end

  end
end