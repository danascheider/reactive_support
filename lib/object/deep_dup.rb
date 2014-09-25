# This file adds the +#deep_dup method to Ruby's core Array and Hash objects.

class Array
  
  # When called on an array, the +#deep_dup+ method duplicates all the members
  # of the array, so that actions on the duplicate do not affect the original:
  #     arr = [1, 2, [3, 4]]                  # => [1, 2, [3, 4]]
  #     dup, deep = arr.dup, arr.deep_dup     # => [1, 2, [3, 4]], [1, 2, [3, 4]]
  #     
  #     deep[2][1] = 5                        # => [1, 2, [3, 5]]
  #     p arr                                 # => [1, 2, [3, 4]]
  #
  #     dup[2][1] = 5                         # => [1, 2, [3, 5]]
  #     p arr                                 # => [1, 2, [3, 5]]

  def deep_dup
    self.map {|item| item.deep_dup }
  end
end