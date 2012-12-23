module GameOfLife
  class Runner

    TIME_BETWEEN_GENERTIONS=0.25

    def initialize(board, console_outputter)
      @board = board
      @console_outputter = console_outputter
    end

    def run
      while @board.has_any_living_cells?
        @console_outputter.show_board(@board)
        @board.advance_generation
        sleep(TIME_BETWEEN_GENERTIONS)
      end
    end

  end
end
