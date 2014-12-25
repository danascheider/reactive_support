require 'reactive_support/core_ext/object/acts_like'

# Ruby's core Time class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Time.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Time.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Time.html].

class Time

  # The +#acts_like_time?+ method is implemented here so that, when 
  # +#acts_like?(:time)+ is called on a +Time+ object (or on an object
  # belonging to a subclass of +Time+), +true+ will be returned.
  #
  # Calling +#acts_like_time?+ directly is probably not useful; this
  # method is defined only for the +Time+ class and will therefore raise
  # a +NoMethodError+ if called on an object of another class. Consequently,
  # it can only be called directly on an object already known to belong
  # to the Time class (unless you want to handle the exception in your code).
  #
  # Examples of direct usage:
  #     t, i = Time.now, 10
  #     t.acts_like_time?         # => true
  #     i.acts_like_time?         # => NoMethodError
  #
  # Examples of recommended usage:
  #     t, i = Time.now, 10
  #     t.acts_like?(:time)       # => true
  #     i.acts_like?(:time)       # => false

  def acts_like_time?
    true
  end
end