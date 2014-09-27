# Ruby's core Object class. See documentation for version 
# 2.1.3[http://ruby-doc.org/core-2.1.3/Object.html],
# 2.0.0[http://ruby-doc.org/core-2.1.3/Object.html], or 
# 1.9.3[http://ruby-doc.org/core-2.0.0/Object.html].

class Object
  
  # The +#deep_dup+ method returns a duplicate of a duplicable object. If the 
  # object calling +#deep_dup+ is not duplicable, the object itself is returned.
  # +#deep_dup+ is overwritten in the Array and Hash classes (see +./object/deep_dup.rb+).
  # In those classes, it duplicates the object recursively so the members of the
  # enumerable can be manipulated without affecting the original object.

  def deep_dup
    duplicable? ? self.dup : self
  end
end

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