class Object

  # The +#acts_like?+ method checks whether the class of the calling object
  # has implemented an +#acts_like_<class>?+ method, returning true if it has.
  # In general, it is up to you to implement that method. ActiveSupport has 
  # +#acts_like_<class>?+ methods implemented for certain classes, including
  # +Time+; currently, those parts of ActiveSupport have not been incorporated
  # into ReactiveSupport.
  #
  # Examples:
  #     class String
  #       def acts_like_string?
  #         true
  #       end
  #     end
  #
  #     "foo".acts_like?(:string)     # => true
  #     187.acts_like?(:string)       # => false

  def acts_like?(sym)
    respond_to? :"acts_like_#{sym}?"
  end
end