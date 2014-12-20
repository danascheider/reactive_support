class Object

  # Called on a generic object that doesn't implement its own +#to_param+ method, 
  # the +#to_param+ method aliases +#to_s+. Like +#to_s+, it is non-destructive;
  # the original object is not changed when +#to_param+ is called.
  #
  # Examples:
  #     a = 1
  #     a.to_param      # => "1"
  #     a               # => 1

  def to_param
    to_s
  end
end

class NilClass

  # Called on +NilClass+, the +#to_param+ method returns +nil+.

  def to_param
    self
  end
end

class TrueClass

  # Called on +TrueClass+, the +#to_param+ method returns +true+.

  def to_param
    self
  end
end

class FalseClass

  # Called on +FalseClass+, the +#to_param+ method returns +false+.

  def to_param
    self 
  end
end

class Array

  # When called on an array, the +#to_param+ method first calls +#to_param+ on
  # all members of the array, and then joins them into a string separated by 
  # forward slashes. The +#to_param+ method is non-destructive; the original 
  # array and its members are still available after +#to_param+ has been executed.
  #
  # Examples:
  #     array = ['foo', 12, :bar]
  #     array.to_param                # => 'foo/12/bar'
  #     array                         # => ['foo', 12, :bar]

  def to_param
    collect(&:to_param).join('/')
  end
end