require "surrogate/rspec"

class MockCell
  Surrogate.endow(self)
  define(:alive?) { false }
  define(:number_of_living_neighbors) { 0 }
  define(:location) { [1, 2] }
end