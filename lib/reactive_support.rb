require_relative 'object/blank.rb'
require_relative 'object/duplicable.rb'
require_relative 'object/deep_dup.rb'

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

  # The +#try+ method calls the given +method+ (with given +*args+ and +&block+)
  # on the object calling it. The +#try+ method returns the output of the 
  # method or, if an error is raised, +nil+. It accepts an arbitrary number 
  # of arguments and an optional block, enabling it to be used with any method.
  #
  # The given +method+ is the name of the method to be called, given as a symbol.
  # +*args+ refers to all the arguments (if any) that should be passed into that
  # method. Likewise, the +&block+ parameter will be passed on to the method
  # being called.
  #
  # Examples of a method being called without args:
  #     'foo'.try(:upcase)           # => 'FOO'
  #     {foo: 'bar'}.try(:upcase)    # => nil
  #
  # Examples of a method being called with args:
  #     %w(foo bar baz).try(:join, '.') # => 'foo.bar.baz'
  #     { foo: 'bar' }.try(:join, '.')  # => nil
  #
  # Examples of a method being called with a block:
  #     { foo: 10, bar: 18, baz: 32 }.try(:reject!) {|k,v| v < 25 } # => { baz: 32 }
  #     nil.try(:reject) {|k,v| v == 'foo' }                        # => nil

  def in?(object)
    object.include?(self)
  rescue NoMethodError
    raise ArgumentError.new("The parameter passed to #in? must respond to #include?")
  end

  def try(method, *args, &block)
    begin
      block_given? ? self.send(method, *args, &block) : self.send(method, *args)
    rescue
      nil
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