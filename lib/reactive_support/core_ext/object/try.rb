class Object
  
  # The +#try+ method calls a given method (with given +*args+ and +&block+)
  # on the object calling it. If the receiving object is +nil+, then the +#try+ 
  # method returns +nil+; otherwise, +#try+ returns the output of the method 
  # passed to it, or any error raised when the method is called. 
  # It accepts an arbitrary number of arguments and an optional block, 
  # enabling it to be used with any method.
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