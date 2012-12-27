require "surrogate/rspec"

class MockOutputter
  Surrogate.endow(self)
  define(:show_board) { |board| }
  # define :show_board do |board|
  # end
end