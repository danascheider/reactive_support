class Hash

  # The +#clean+ method returns a hash identical to the calling hash but
  # with the given +*keys+, if present, removed. If all the keys in the
  # hash are given as arguments, an empty hash is returned. The +#clean+ 
  # method is non-destructive; the original hash is still available after 
  # it is called. It does have a destructive form, +#clean!+.
  # 
  # Examples:
  #     hash = {:foo => 'bar'}
  #     hash.clean(:baz)          # => {:foo => 'bar'}
  #     hash.clean(:foo)          # => {}
  #     hash                      # => {:foo => 'bar'}
  #
  # Examples with multiple arguments:
  #     hash = { 'foo' => 'bar', 'baz' => 'qux', => :norf => 'raboof' }
  #     hash.clean('foo', :norf)  # => {'baz' => 'qux'}
  #     hash                      # => { 'foo' => 'bar', 'baz' => 'qux', :norf => 'raboof' }

  def clean(*keys)
    self.reject {|k,v| k.in?(keys) }
  end

  # The +#clean!+ method returns a hash identical to the calling hash but
  # with the given +*keys+, if present, removed. If all the keys in the
  # hash are given as arguments, an empty hash is returned. The +#clean!+ 
  # method is non-destructive; the original hash is still available after 
  # it is called. It does have a non-destructive form, +#clean+.
  # 
  # Examples where hash is not changed:
  #     hash = {:foo => 'bar'}
  #     hash.clean!(:baz)         # => {:foo => 'bar'}
  #     hash                      # => {:foo => 'bar'}
  #
  # Examples where hash is changed: 
  #     hash = {'foo' => 'bar'}
  #     hash.clean!(:foo)         # => {}
  #     hash                      # => {}
  #
  # Examples with multiple arguments:
  #     hash = { 'foo' => 'bar', 'baz' => 'qux', => :norf => 'raboof' }
  #     hash.clean('foo', :norf)  # => {'baz' => 'qux'}
  #     hash                      # => {'baz' => 'qux'}

  def clean!(*keys)
    self.reject! {|k,v| k.in?(keys) }
    self
  end
end