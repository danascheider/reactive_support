Dir['./lib/reactive_support/core_ext/**/*.rb'].each {|f| require f }
Dir['./lib/reactive_support/extensions/**/*.rb'].each {|f| require f }

# The ReactiveSupport module implements methods from ActiveSupport. It can be
# included in Ruby's +Object+ class by adding +require 'reactive_support'+ to
# your project file. Then, ReactiveSupport methods can be called on any Ruby
# object just like the object's own methods.
# 
# In this example, ReactiveSupport's #try method is called on an array:
#     require 'reactive_support'
#     require 'reactive_support/core_ext/array/try'
#     
#     arr = %w(foo, bar, baz)
#     arr.try(:join, '.') 

module ReactiveSupport
end