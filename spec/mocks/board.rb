require "surrogate/rspec"

class MockBoard
  Surrogate.endow(self)
  define(:has_any_living_cells?) do
    @number_of_remaining_generations > 0
  end
  define(:advance_generation) do
    @number_of_remaining_generations -= 1
  end

  define(:bring_to_life_at) { | location| }
  define(:has_living_cell_at?) { |location| }

  attr_accessor :number_of_remaining_generations
end