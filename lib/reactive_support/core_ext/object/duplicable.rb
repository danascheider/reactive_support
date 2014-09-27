class Object

  # The +#duplicable?+ method checks whether an object may be safely duplicated.
  # It returns true, unless the object calling it has its own method called 
  # +#duplicable?+. The +#duplicable?+ method is defined for non-duplicable
  # classes in +./object/duplicable.rb+.

  def duplicable?
    true
  end
end

# Define +#duplicable?+ for all of the classes in the array.

[NilClass, FalseClass, TrueClass, Method, Symbol, Numeric].each do |klass|
  klass.class_eval do 
    def duplicable?
      false 
    end
  end
end

require 'bigdecimal'

# BigDecimal class from Ruby's standard library. See documentation for version
# 2.1.3[http://www.ruby-doc.org/stdlib-2.1.3/libdoc/bigdecimal/rdoc/BigDecimal.html],
# 2.0.0[http://ruby-doc.org/stdlib-2.0.0/libdoc/bigdecimal/rdoc/BigDecimal.html], or
# 1.9.3[http://www.ruby-doc.org/stdlib-1.9.3/libdoc/bigdecimal/rdoc/BigDecimal.html].

class BigDecimal

  # This is required for compatibility with Ruby 1.9.x. In Ruby 1.9.x, 
  # +dup+ is not allowed on a BigDecimal and raises a TypeError. Rescue
  # the type error to simply return false.

  def duplicable?
    !!self.dup rescue super
  end
end