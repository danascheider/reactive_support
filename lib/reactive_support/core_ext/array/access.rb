class Array 

  # The +#from+ method returns the tail of the array starting at the given 
  # +position+.
  #     [1, 2, 3, 4, 5].from(2)     # => [3, 4, 5]
  #     [1, 2, 3, 4, 5].from(0)     # => [1, 2, 3, 4, 5]
  #     [1, 2, 3, 4, 5].from(-2)    # => [4, 5]
  #
  # +#from+ returns an empty array if the receiving array is empty, the given
  # +position+ exceeds the maximum index of the array, or the given +position+
  # is lower than the array's minimum (i.e., largest negative) index.
  #     [].from(0)                  # => []
  #     [1, 2, 3, 4, 5].from(10)    # => []
  #     [1, 2, 3, 4, 5].from(-10)   # => []

  def from(position)
    self[position, length] ||  []
  end

  # The +#to+ method returns the beginning of the array up to and including
  # the given +position+.
  #     [1, 2, 3, 4, 5].to(2)       # => [1, 2, 3]
  #     [1, 2, 3, 4, 5].to(10)      # => [1, 2, 3, 4, 5]
  #     [1, 2, 3, 4, 5].to(-2)      # => [1, 2, 3, 4]
  #
  # +#to+ returns an empty array if the receiving array is empty or the given 
  # +position+ falls below the minimum (negative) index.
  #     [].to(0)                    # => []
  #     [1, 2, 3, 4, 5].to(-10)     # => []

  def to(position)
    self[0..position]
  end
end