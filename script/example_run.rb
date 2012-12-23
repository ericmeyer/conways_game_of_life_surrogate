$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require "game_of_life/board"
require "game_of_life/console_outputter"
require "game_of_life/runner"

board = GameOfLife::Board.new
board.bring_to_life_at([14, 14])
board.bring_to_life_at([14, 15])
board.bring_to_life_at([14, 16])
board.bring_to_life_at([13, 16])
board.bring_to_life_at([12, 15])
runner = GameOfLife::Runner.new(board, GameOfLife::ConsoleOutputter.new)
runner.run