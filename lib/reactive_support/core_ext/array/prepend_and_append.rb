class Array

  # The +#append+ method adds a given +object+ to the end of the 
  # calling array. It is a destructive method; the array is altered
  # in place and is no longer available without the added element.
  #
  # Examples:
  #     arr = [1, 2, 3]
  #     arr.append(4)       # => [1, 2, 3, 4]
  #     arr                 # => [1, 2, 3, 4]

  alias_method :append, :<<

  # The +#prepend+ method adds a given +object+ to the beginning of 
  # the calling array. It is a destructive method; the array is altered
  # in place and is no longer available without the added element.
  #
  # Examples:
  #     arr = [1, 2, 3]
  #     arr.prepend(0)      # => [0, 1, 2, 3]
  #     arr                 # => [0, 1, 2, 3]

  alias_method :prepend, :unshift
end