require "game_of_life/runner"
require "mocks/outputter"
require "mocks/board"

module GameOfLife
  describe Runner do

    before(:each) do
      @outputer = MockOutputter.new
      @board = MockBoard.new
      @runner = Runner.new(@board, @outputer)
      @runner.stub(:sleep)
    end

    context "with only one remaining generation" do
      before(:each) do
        @board.number_of_remaining_generations = 1
      end

      it "outputs the board" do
        @runner.run
        @outputer.should have_been_told_to(:show_board).with(@board)
      end

      it "advances the board's generation" do
        @runner.run
        @board.should have_been_told_to(:advance_generation)
      end

      it "pauses between loops" do
        @runner.should_receive(:sleep).with(Runner::TIME_BETWEEN_GENERATIONS)
        @runner.run
      end
    end

    context "with multiple remaining generations" do
      before(:each) do
        @board.number_of_remaining_generations = 5
      end

      it "shows the board for each generation" do
        @runner.run
        @outputer.should have_been_told_to(:show_board).times(5)
      end

      it "sleeps between each generation" do
        @runner.should_receive(:sleep).with(Runner::TIME_BETWEEN_GENERATIONS).exactly(5).times
        @runner.run
      end
    end

  end
end