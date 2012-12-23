require "game_of_life/runner"
require "game_of_life/board"

module GameOfLife
  describe Runner do

    before(:each) do
      @outputer = mock('ConsoleOutputter', show_board: nil)
      @board = mock('board', has_any_living_cells?: true, advance_generation: nil)
      @runner = Runner.new(@board, @outputer)
      @runner.stub(:sleep)
    end

    it "outputs the board" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @outputer.should_receive(:show_board).with(@board)
      @runner.run
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
      @outputer.should_receive(:show_board).exactly(2).times
      @runner.run
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