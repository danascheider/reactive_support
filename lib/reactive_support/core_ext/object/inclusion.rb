class Object

  # The +#in?+ method returns +true+ if the calling object is included in the
  # +object+ passed as a parameter. The +object+ parameter must be a String,
  # Enumerable, or other object that responds to +#include?+. If it doesn't, 
  # the #in? method will raise an ArgumentError.
  #
  # When passed an Array object, +#in?+ returns +true+ if the calling object
  # is included as a member of the array:
  # 
  #     'foo'.in? ['foo', 'bar']    # => true
  #     'foo'.in? ['bar', 'baz']    # => false
  #
  # When passed a Hash object, +#in?+ returns true if the calling object is
  # included as a key in the hash. To look for an object in a hash's values,
  # use the hash's +#values+ method.
  #
  #     'foo'.in? {'foo' => 'bar'}          # => true 
  #     'foo'.in? {'bar' => 'foo'}          # => false
  #     'foo'.in? {'bar' => 'foo'}.values   # => true 
  # 
  # When passed a String object, +#in?+ returns +true+ if the the calling object
  # (which must also be a string) appears verbatim within the parameter object.
  # If the passed-in object is a string but the calling object is something else,
  # a TypeError will be returned.
  #
  #     'foo'.in? 'foobar'    # => true
  #     'foo'.in? 'foto'      # => false
  #     ['foo'].in? 'foobar'  # => TypeError
  #
  # When passed an object that does not respond to +#include?+, +#in?+ raises
  # an ArgumentError.

  def in?(object)
    object.include?(self)
  rescue NoMethodError
    raise ArgumentError.new("The parameter passed to #in? must respond to #include?")
  end
end