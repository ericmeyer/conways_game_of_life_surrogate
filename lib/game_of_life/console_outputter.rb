module GameOfLife
  class ConsoleOutputter

    def show_board(board)
      30.times do |row|
        30.times do |col|
          if board.has_living_cell_at?([row, col])
            print "X"
          else
            print '-'
          end
        end
        puts "\n"
      end
    end

  end
end