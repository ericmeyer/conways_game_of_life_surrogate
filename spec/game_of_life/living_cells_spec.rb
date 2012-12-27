require "game_of_life/living_cells"
require "mocks/cell"

module GameOfLife
  describe LivingCells do
    it "implements the methods defined in MockCell" do
      MockCell.should be_substitutable_for(LivingCells::Cell)
    end
  end
end