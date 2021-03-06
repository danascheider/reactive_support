# This file adds the +#blank?+ and +#present?+ methods to core Ruby classes
# The +#blank?+ method returns +true+ if the object is undefined, blank, false,
# empty, or nil. The +#present?+ method returns the opposite of +#blank?+

# Ruby's core Object class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Object.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Object.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Object.html].

class Object

  # When called on a generic object, the +#blank?+ method returns +true+ if 
  # the object is false, empty, or nil. Other objects return +false+.
  # For specific examples of different classes, see the class-specific 
  # definitions of +#blank?+.
  #     Time.now.blank?  # => false

  def blank?
    respond_to?(:empty) ? !!empty : !self
  end

  # When called on a generic object, the +#present?+ method returns +true+ if
  # the object is present and not empty. If the object is false, empty, or nil,
  # +#present?+ returns +false+. For specific examples of different classes, see
  # the class-specific definitions of +#present?+.
  #     Time.now.present?  # => true

  def present? 
    !blank?
  end
end

# Ruby's core String class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/String.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/String.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/String.html].

class String

  # When called on a string, the +#blank?+ method returns +true+ if the string
  # is empty or consists only of whitespace:
  #     ''.blank?      # => true 
  #     " \n ".blank?  # => true 
  #     'foo'.blank?   # => false

  def blank?
    !!(/\A[[:space:]]*\z/ =~ self) || self.empty?
  end

  # When called on a string, the +#present?+ method returns +true+ unless the 
  # string is empty or consists only of whitespace:
  #     'foo'.present?  # => true 
  #     ''.present?     # => false 
  #     '   '.present?  # => false

  def present?
    !blank?
  end
end

# Ruby's core Array class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.3/Array.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Array.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Array.html].

class Array

  # When called on an array, the +#blank?+ method is aliased to +#empty?+ 
  # and returns +true+ when the array has no elements. Note that +#blank?+ 
  # returns +false+ if the array has elements that are themselves all blank:
  #     [].blank?               # => true
  #     ['foo', 'bar'].blank?   # => false
  #     [false, nil, ''].blank? # => false

  alias_method :blank?, :empty?

  # When called on an array, the +#present?+ method returns +true+ if the 
  # array has any elements. Note that +#present?+ also returns +true+ if the
  # array consists of blank values:
  #     ['foo', 'bar'].present?    # => true 
  #     [false, nil].present?      # => true 
  #     [].present?                # => false

  def present?
    !blank?
  end
end

# Ruby's core Hash class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Hash.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Hash.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Hash.html].

class Hash

  # When called on a hash (or any enumerable), the +#blank?+ method is aliased
  # to +#empty?+ and as such returns +true+ if the hash is empty:
  #     {}.blank?              # => true 
  #     { foo: 'bar' }.blank?  # => false
  #     { foo: nil }.blank?    # => false

  alias_method :blank?, :empty?

  # When called on a hash (or any enumerable), the +#present?+ method returns 
  # +true+ if the hash is not empty, even if its elements have blank values:
  #     { foo: :bar }.present?      # => true
  #     { 'bar' => nil }.present?   # => true
  #     {}.present?                 # => false

  def present?
    !blank?
  end
end

# Ruby's core NilClass (the singleton class consisting of the +nil+ object). 
# See documentation for version 2.1.5[http://ruby-doc.org/core-2.1.5/NilClass.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/NilClass.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/NilClass.html].

class NilClass

  # +nil+ is considered blank by definition; if +#blank?+ is called on +nil+,
  # it will always return +true+:
  #     nil.blank?        # => true
  #
  #     # When the +foo+ variable is undefined or set to nil:
  #     foo.blank?        # => true

  def blank?
    true
  end

  # Likewise, +nil+ is not present by definition; if +#present?+ is called on 
  # +nil+, it will always return +false+:
  #     nil.present?      # => false
  # 
  #     # When the +foo+ variable is undefined or set to nil:
  #     foo.present?      # => false

  def present?
    false
  end
end

# Ruby's core TrueClass (the singleton class consisting of the +true+ object).
# See documentation for version 2.1.5[http://ruby-doc.org/core-2.1.5/TrueClass.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/TrueClass.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/TrueClass.html].

class TrueClass

  # +true+ is not blank by definition; when called on +true+, the +#blank?+
  # method will return +false+:
  #     true.blank?   # => false

  def blank?
    false
  end

  # +true+ is present by definition; when called on +true+, the +#present?+
  # method will return +true+:
  #     true.present?   # => true

  def present?
    true 
  end
end

# Ruby's core FalseClass (the singleton class consisting of the +false+ object).
# See documentation for version 2.1.5[http://ruby-doc.org/core-2.1.5/FalseClass.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/FalseClass.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/FalseClass.html].

class FalseClass

  # +false+ is blank by definition; when called on +false+, the +#blank?+
  # method will return +true+:
  #     false.blank?    # => true 

  def blank?
    true
  end

  # +false+ is not present by definition; when called on +false+, the +#present?+
  # method will return +false+:
  #     false.present?    # => false

  def present? 
    false 
  end
end

# Ruby's core Numeric class, the parent class of Integer, Fixnum, Bignum, Float,
# and Rational. See documentation for version 2.1.5[http://ruby-doc.org/core-2.1.5/Numeric.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Numeric.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Numeric.html].

class Numeric 

  # Numbers can never be blank; when called on any +Numeric+ (including +Fixnum+,
  # +Bignum+, +Float+, +Integer+, and +Rational+), the +#blank?+ method will
  # return +false+:
  #     10.blank?     # => false

  def blank?
    false 
  end

  # Numbers are always present; when called on any +Numeric+ (including +Fixnum+,
  # +Bignum+, +Float+, +Integer+, and +Rational+), the +#present?+ method will
  # return +true+:
  #     Math.PI.present?    # => true

  def present? 
    true 
  end
end