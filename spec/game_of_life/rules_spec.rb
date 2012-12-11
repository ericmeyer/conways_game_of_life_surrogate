require "game_of_life/rules"

describe GameOfLife::Rules do
  context "with a living cell" do
    it "dies with 1 living neighbor" do
      cell = mock('Cell', is_alive: true, number_of_living_neighbors: 1)
      GameOfLife::Rules.should_live_in_next_generation?(cell).should == false
    end

    it "stays alive with 2 living neighbors" do
      cell = mock('Cell', is_alive: true, number_of_living_neighbors: 2)
      GameOfLife::Rules.should_live_in_next_generation?(cell).should == true
    end

    it "stays alive with 3 living neighbors" do
      cell = mock('Cell', is_alive: true, number_of_living_neighbors: 3)
      GameOfLife::Rules.should_live_in_next_generation?(cell).should == true
    end

    it "dies with 4 living neighbors" do
      cell = mock('Cell', is_alive: true, number_of_living_neighbors: 4)
      GameOfLife::Rules.should_live_in_next_generation?(cell).should == false
    end
  end

  context "with a dead cell" do
    it "stays dead with 2 living neighbors" do
      cell = mock('Cell', is_alive: false, number_of_living_neighbors: 2)
      GameOfLife::Rules.should_live_in_next_generation?(cell).should == false
    end

    it "comes to life with 3 living neighbors" do
      cell = mock('Cell', is_alive: false, number_of_living_neighbors: 3)
      GameOfLife::Rules.should_live_in_next_generation?(cell).should == true
    end
  end
end
