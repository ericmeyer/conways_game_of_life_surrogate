class Cell

  attr_reader :location, :number_of_living_neighbors

  def initialize(options)
    @location = options[:location]
    @is_alive = options[:is_alive]
    @number_of_living_neighbors = options[:number_of_living_neighbors]
  end

  def alive?
    @is_alive
  end

end

class LivingCells

  def initialize
    @living_locations = Set.new
  end

  def bring_to_life_at(location)
    @living_locations.add location
  end

  def has_living_cell_at?(location)
    @living_locations.include? location
  end

  def each_potential_living_cell(&block)
    potential_living_locations.each do |location|
      yield Cell.new({
        location: location,
        is_alive: has_living_cell_at?(location),
        number_of_living_neighbors: number_of_living_neighbors_for(location)
      })
    end
  end

  def number_of_living_neighbors_for(location)
    neighbors_of(location).inject(0) do |count, location|
      count += 1 if has_living_cell_at? location
      count
    end
  end

  private

  def potential_living_locations
    @living_locations.inject(Set.new) do |potential_locations, location|
      potential_locations += Set.new([location]) + neighbors_of(location)
    end
  end

  def neighbors_of(location)
    x = location[0]
    y = location[1]
    Set.new([
      [x-1, y-1],
      [x-1, y],
      [x-1, y+1],
      [x, y-1],
      [x, y+1],
      [x+1, y-1],
      [x+1, y],
      [x+1, y+1]
    ])
  end
end

class Board

  def initialize
    @living_cells = LivingCells.new
  end

  def bring_to_life_at(location)
    @living_cells.bring_to_life_at location
  end

  def has_living_cell_at?(location)
    @living_cells.has_living_cell_at? location
  end

  def advance_generation
    next_generation = LivingCells.new
    @living_cells.each_potential_living_cell do |cell|
      next_generation.bring_to_life_at(cell.location) if should_live_to_next_generation?(cell)
    end
    @living_cells = next_generation
  end

  private

  def should_live_to_next_generation?(cell)
    case cell.number_of_living_neighbors
    when 2
      cell.alive?
    when 3
      true
    else
      false
    end
  end
end

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


