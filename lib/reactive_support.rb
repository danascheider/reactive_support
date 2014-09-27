Dir['./lib/reactive_support/core_ext/object/**/*.rb'].each {|f| require f }

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