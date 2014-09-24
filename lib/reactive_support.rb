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

  # The +#try+ method calls the given +method+ (with given +*args+ and +&block+)
  # on the object calling it, returning the output of the method or, if an error is
  # raised, +nil+. It accepts an arbitrary number of arguments and an
  # optional block, enabling it to be used with any method.
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