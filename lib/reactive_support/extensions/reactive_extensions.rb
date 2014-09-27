require 'reactive_support'

# The ReactiveExtensions module consists of methods I wish ActiveSupport provided.
# These methods do not adhere to the ActiveSupport API. If you wish to include
# them in your project, you will need to put this in your main project file:
#     require 'reactive_support/extensions'
#
# ReactiveExtensions requires ReactiveSupport, so there is no need to require both
# explicitly.

module ReactiveExtensions

  # The +#try_rescue+ method extends ReactiveSupport's +#try+ method so it
  # rescues NoMethodErrors and TypeErrors as well as returning +nil+ when
  # called on a +nil+ value.
  #
  # Like the +#try+ method, +#try_rescue+ takes 1 or more arguments. The first
  # argument is the method to be called on the calling object, passed as a 
  # symbol. The others are zero or more arguments that will be passed through to 
  # that method, and +&block+ is an optional block that will be similarly passed through.
  #
  # Example of usage identical to +#try+:
  #     nil.try(:map) {|a| a.to_s }           # => nil
  #     nil.try_rescue(:map) {|a| a.to_s }    # => nil
  #     
  # Example of usage calling a method that is not defined on the calling object:
  #     10.try(:to_h)           # => TypeError
  #     10.try_rescue(:to_h)    # => nil
  #
  # Example of usage with invalid arguments:
  #     %w(foo, bar, baz).try(:join, [:hello, :world])        # => TypeError
  #     %w(foo, bar, baz).try_rescue(:join, [:hello, :world]) # => nil

  def try_rescue(*args, &block)
    self.try(*args, &block) rescue nil
  end
end

class Object
  include ReactiveExtensions
end