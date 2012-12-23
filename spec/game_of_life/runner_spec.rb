require "game_of_life/runner"
require "game_of_life/board"
require "surrogate/rspec"

class MockOutputter
  Surrogate.endow(self)
  define(:show_board) { |board| }
end

module GameOfLife
  describe Runner do

    before(:each) do
      @outputer = MockOutputter.factory
      @board = mock('board', has_any_living_cells?: true, advance_generation: nil)
      @runner = Runner.new(@board, @outputer)
      @runner.stub(:sleep)
    end

    it "outputs the board" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @runner.run
      @outputer.should have_been_told_to(:show_board).with(@board)
    end

    it "advances the board's generation" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @board.should_receive(:advance_generation)
      @runner.run
    end

    it "pauses between loops" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @runner.should_receive(:sleep).with(Runner::TIME_BETWEEN_GENERTIONS)
      @runner.run
    end

    it "shows the board until there are no living cells" do
      @board.stub(:has_any_living_cells?).and_return(true, true, false)
      @runner.run
      @outputer.should have_been_told_to(:show_board).times(2)
    end

    xit "has an example" do
      require "game_of_life/console_outputter"
      board = Board.new
      board.bring_to_life_at([14, 14])
      board.bring_to_life_at([14, 15])
      board.bring_to_life_at([14, 16])
      board.bring_to_life_at([13, 16])
      board.bring_to_life_at([12, 15])
      runner = Runner.new(board, ConsoleOutputter.new)
      runner.run
    end

  end
end