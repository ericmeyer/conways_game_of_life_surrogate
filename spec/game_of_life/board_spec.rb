require "game_of_life/board"

module GameOfLife

  describe Board do
    before(:each) do
      @board = Board.new
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

    xit "has an example" do
      @board.bring_to_life_at([4, 4])
      @board.bring_to_life_at([4, 5])
      @board.bring_to_life_at([4, 6])
      @board.bring_to_life_at([3, 6])
      @board.bring_to_life_at([2, 5])
      200.times do
        30.times do |row|
          30.times do |col|
            if @board.has_living_cell_at?([row, col])
              print "X"
            else
              print '-'
            end
          end
          puts "\n"
        end
        @board.advance_generation
        puts '#' * 30
        sleep 0.2
      end
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
