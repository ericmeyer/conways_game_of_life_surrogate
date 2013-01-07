require "game_of_life/rules"

describe GameOfLife::Rules do
  context "with a living cell" do
    it "dies with 1 living neighbor" do
      cell = mock('cell', alive?: true, number_of_living_neighbors: 1)
      GameOfLife::Rules.should_not be_alive_in_next_generation(cell)
    end

    it "stays alive with 2 living neighbors" do
      cell = mock('cell', alive?: true, number_of_living_neighbors: 2)
      GameOfLife::Rules.should be_alive_in_next_generation(cell)
    end

    it "stays alive with 3 living neighbors" do
      cell = mock('cell', alive?: true, number_of_living_neighbors: 3)
      GameOfLife::Rules.should be_alive_in_next_generation(cell)
    end

    it "dies with 4 living neighbors" do
      cell = mock('cell', alive?: true, number_of_living_neighbors: 4)
      GameOfLife::Rules.should_not be_alive_in_next_generation(cell)
    end
  end

  context "with a dead cell" do
    it "stays dead with 2 living neighbors" do
      cell = mock('cell', alive?: false, number_of_living_neighbors: 2)
      GameOfLife::Rules.should_not be_alive_in_next_generation(cell)
    end

    it "comes to life with 3 living neighbors" do
      cell = mock('cell', alive?: false, number_of_living_neighbors: 3)
      GameOfLife::Rules.should be_alive_in_next_generation(cell)
    end
  end
end
