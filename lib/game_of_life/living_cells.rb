module GameOfLife
  class LivingCells

    class Cell
      attr_reader :location, :number_of_living_neighbors

      def initialize(location, number_of_living_neighbors, is_alive)
        @location, @number_of_living_neighbors, @is_alive = location, number_of_living_neighbors, is_alive
      end

      def alive?
        @is_alive
      end
    end

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
        yield Cell.new(
          location,
          number_of_living_neighbors_for(location),
          has_living_cell_at?(location)
        )
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
end