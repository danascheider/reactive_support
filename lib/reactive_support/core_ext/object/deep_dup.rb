# This file adds the +#deep_dup method to Ruby's core Array and Hash objects.

class Array

  # When called on an array, the +#deep_dup+ method duplicates all the members
  # of the array recursively, so that actions on the duplicate do not affect 
  # the original:
  #
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

class Hash 

  # When called on a hash, the +#deep_dup+ method duplicates all the key-value
  # pairs in the hash recursively, so that actions on the duplicate do not affect
  # the original hash:
  #
  # hash = {a: {b: 2}}                        # => {a: {b: 2}}
  # dup, deep = hash.dup, hash.deep_dup       # => {a: {b: 2}}, {a: {b: 2}}
  #
  # deep[:a][:b] = 14                         # => {a: {b: 14}}
  # p hash                                    # => {a: {b: 2}}
  #
  # dup[:a][:b] = 14                          # => {a: {b: 14}}
  # p hash                                    # => {a: {b: 14}}

  def deep_dup
    self.each_with_object(dup) do |(key, value), hash|
      hash[key.deep_dup] = value.deep_dup
    end
  end
end