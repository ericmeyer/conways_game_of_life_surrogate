require "game_of_life/living_cells"
require "surrogate/rspec"

module GameOfLife
  describe LivingCells do
    it "implements the methods defined in MockCell" do
      LivingCells::Cell.should substitute_for(MockCell)
    end
  end
end