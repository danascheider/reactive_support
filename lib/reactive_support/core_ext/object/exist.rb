class Object

  # The +#exists?+ method and its alias, +#exist?+, return +true+ if the object
  # calling the method is not +nil+.
  #
  #     'foobar'.exists?      # => true 
  #     nil.exists?           # => false

  def exists?
    !self.nil?
  end

  alias_method :exist?, :exists?
end