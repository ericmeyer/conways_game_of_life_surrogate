require "mocks/board"

=begin
 I don't normally test my mocks,
 but I thought it was useful to show
 an example of how this is used
=end
describe MockBoard do

  before(:each) do
    @mock_board = MockBoard.new
  end

  it "has a number of remaining generations" do
    @mock_board.number_of_remaining_generations = 123
    @mock_board.number_of_remaining_generations.should == 123
  end

  it "uses a generation" do
    @mock_board.number_of_remaining_generations = 5
    @mock_board.advance_generation
    @mock_board.number_of_remaining_generations.should == 4
  end

  context "#has_any_living_cells?" do
    it "has living cells at least 1 remaining generation" do
      @mock_board.number_of_remaining_generations = 1
      @mock_board.should have_any_living_cells
    end

    it "has none with 0 remaining generations" do
      @mock_board.number_of_remaining_generations = 0
      @mock_board.should_not have_any_living_cells
    end

    it "has none with less than 0 remaining generations" do
      @mock_board.number_of_remaining_generations = -123
      @mock_board.should_not have_any_living_cells
    end
  end

end