require "game_of_life/runner"

module GameOfLife
  describe Runner do

    before(:each) do
      @outputter = mock('ConsoleOutputter', show_board: nil)
      @board = mock('board', has_any_living_cells?: true, advance_generation: nil)
      @runner = Runner.new(@board, @outputter)
      @runner.stub(:sleep)
    end

    it "outputs the board" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @outputter.should_receive(:show_board).with(@board)
      @runner.run
    end

    it "advances the board's generation" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @board.should_receive(:advance_generation)
      @runner.run
    end

    it "pauses between loops" do
      @board.stub(:has_any_living_cells?).and_return(true, false)
      @runner.should_receive(:sleep).with(Runner::TIME_BETWEEN_GENERATIONS)
      @runner.run
    end

    it "shows the board until there are no living cells" do
      @board.stub(:has_any_living_cells?).and_return(true, true, false)
      @outputter.should_receive(:show_board).exactly(2).times
      @runner.run
    end

  end
end
