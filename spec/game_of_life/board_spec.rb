require "game_of_life/board"
require "mocks/board"

module GameOfLife

  describe Board do
    before(:each) do
      @board = Board.new
    end

    it "implements the methods defined in MockBoard" do
      MockBoard.should be_substitutable_for(Board)
    end

    it "kills a cell with no living neighbors" do
      @board.bring_to_life_at([1, 1])
      @board.advance_generation
      @board.should_not have_living_cell_at([1, 1])
    end

    it "allows a cell to live with two living neighbors" do
      @board.bring_to_life_at([0, 1])
      @board.bring_to_life_at([1, 1])
      @board.bring_to_life_at([2, 1])
      @board.advance_generation
      @board.should have_living_cell_at([1, 1])
    end

    it "brings a cell to life" do
      @board.bring_to_life_at([0, 1])
      @board.bring_to_life_at([1, 1])
      @board.bring_to_life_at([2, 1])
      @board.advance_generation
      @board.should have_living_cell_at([1, 2])
    end

    it "stays dead with only 2 living neighbors" do
      @board.bring_to_life_at([0, 1])
      @board.bring_to_life_at([1, 1])
      @board.advance_generation
      @board.should_not have_living_cell_at([1, 2])
    end

    it "has living cells" do
      @board.bring_to_life_at([0, 1])
      @board.should have_any_living_cells
    end

    it "has no living cells" do
      @board.should_not have_any_living_cells
    end

  end

  describe LivingCells do
    it "looks for a neighbor to the down and to the right" do
      @living_cells = LivingCells.new
      @living_cells.bring_to_life_at([-1,1])
      @living_cells.number_of_living_neighbors_for([0,0]).should == 1
    end
  end
end
