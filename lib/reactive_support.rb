Dir['./lib/object/**/*.rb'].each {|f| require f }

# The ReactiveSupport module implements methods from ActiveSupport. It can be
# included in Ruby's +Object+ class by adding +require 'reactive_support'+ to
# your project file. Then, ReactiveSupport methods can be called on any Ruby
# object just like the object's own methods.
# 
# In this example, ReactiveSupport's #try method is called on an array:
#     require 'reactive_support'
#     
#     arr = %w(foo, bar, baz)
#     arr.try(:join, '.') 

module ReactiveSupport

  # The +#deep_dup+ method returns a duplicate of a duplicable object. If the 
  # object calling +#deep_dup+ is not duplicable, the object itself is returned.
  # +#deep_dup+ is overwritten in the Array and Hash classes (see +./object/deep_dup.rb+).
  # In those classes, it duplicates the object recursively so the members of the
  # enumerable can be manipulated without affecting the original object.

  def deep_dup
    duplicable? ? self.dup : self
  end

  # The +#duplicable?+ method checks whether an object may be safely duplicated.
  # It returns true, unless the object calling it has its own method called 
  # +#duplicable?+. The +#duplicable?+ method is defined for non-duplicable
  # classes in +./object/duplicable.rb+.

  def duplicable?
    true
  end

  # The +#exists?+ method and its alias, +#exist?+, return +true+ if the object
  # calling the method is not +nil+.
  #
  #     'foobar'.exists?      # => true 
  #     nil.exists?           # => false

  def exists?
    !self.nil?
  end

  alias_method :exist?, :exists?

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

  # The +#instance_values+ method returns a hash mapping all the calling object's
  # instance variable names to the variables' values. The hash keys are the 
  # variables' names, as strings, without the '@' prepended to them. Each of the
  # hash's values is the value corresponding to the given variable name.
  #
  #     class Widget
  #       def initialize(x,y)
  #         @x, @y = x, y
  #       end
  #     end
  #     
  #     widget = Widget.new('foo', 'bar')
  #     widget.instance_values              # => {'x' => 'foo', 'y' => 'bar'}

  def instance_values
    Hash[instance_variables.map {|name| [name[1..-1], instance_variable_get(name) ] }]
  end

  # The +#instance_variable_names+ method returns an array of the names of 
  # the instance variables defined on the calling object. The names themselves
  # are returned as strings and, unlike in the +#instance_values+ method, 
  # include the +'@'+ prefix.
  #
  #     class Widget
  #       def initialize(x,y)
  #         @x, @y = x, y
  #       end
  #     end
  #
  #     widget = Widget.new(1, 2)
  #     widget.instance_variable_names    # => ['@x', '@y']

  def instance_variable_names
    instance_variables.map {|name| name.to_s }
  end

  # The +#try+ method calls the given +method+ (with given +*args+ and +&block+)
  # on the object calling it. The +#try+ method returns the output of the 
  # method or, if an error is raised, +nil+. It accepts an arbitrary number 
  # of arguments and an optional block, enabling it to be used with any method.
  #
  # The first argument is the name of the method to be called, given as a symbol.
  # The rest are the arguments (if any) that should be passed into that
  # method. Likewise, the +&block+ parameter will be passed on to the method
  # being called.
  #
  # Examples of a method being called without args:
  #     'foo'.try(:upcase)    # => 'FOO'
  #     nil.try(:upcase)      # => nil
  #
  # Examples of a method being called with args:
  #     %w(foo bar baz).try(:join, '.') # => 'foo.bar.baz'
  #     nil.try(:join, '.')             # => nil
  #
  # Examples of a method being called with a block:
  #     { foo: 10, bar: 18, baz: 32 }.try(:reject!) {|k,v| v < 25 } # => { baz: 32 }
  #     nil.try(:reject) {|k,v| v == 'foo' }                        # => nil
  #
  # When called on +nil+, +#try+ returns +nil+ even if the method being sent
  # is defined for NilClass:
  #     nil.try(:inspect)     # => nil
  #
  # The +#try+ method can also be called with a block and no arguments. In this case,
  # the block will be instance_eval'ed:
  #     'foobar'.try { upcase.truncate(3) }     # => 'FOO'
  #     nil.try { upcase.truncate(3) }          # => nil

  def try(*args, &block)
    return self if self.nil?

    if args.empty? && block_given?
      if block.arity.zero?
        instance_eval(&block)
      else
        yield self
      end
    else
      public_send(*args, &block) if args.respond_to?(:first)
    end
  end
end

# Include ReactiveSupport in Ruby's +Object+ class. This enables ReactiveSupport
# methods to be called on any Ruby object without explicit inclusion. 
# ReactiveSupport's methods can then be treated like any other methods that can
# be called on an object.

class Object
  include ReactiveSupport
end