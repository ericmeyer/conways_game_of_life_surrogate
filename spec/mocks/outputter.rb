require "surrogate/rspec"

class MockOutputter
  Surrogate.endow(self)
  define(:show_board) { |board| }
end