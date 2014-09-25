# This file adds the +#duplicable?+ method to the Ruby classes that are 
# not duplicable. It should return false in all cases.

# Define +#duplicable?+ for all of the classes in the array.

[NilClass, FalseClass, TrueClass, Method, Symbol, Numeric].each do |klass|
  klass.class_eval do 
    def duplicable?
      false 
    end
  end
end

# This is required for compatibility with Ruby 1.9.x. In Ruby 1.9.x, 
# +dup+ is not allowed on a BigDecimal and raises a TypeError. Rescue
# the type error to simply return false

require 'bigdecimal'

class BigDecimal
  begin
    !!BigDecimal.new('4.56').dup
  rescue TypeError
    # use superclass implementation
  end
end