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

  # The +#symbolize_keys+ method returns a hash identical to the calling
  # hash but with string keys turned into symbols. It is non-destructive;
  # the original hash is still available after it is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was 
  # already deprecated by the time ReactiveSupport was introduced. For
  # that reason, it is being included as part of ReactiveExtensions.
  #
  # Examples:
  #     orig = { 'foo' => 'bar' }
  #     dup = orig.symbolize_keys
  #
  #     orig      #=> { 'foo' => 'bar' }
  #     dup       #=> { :foo => 'bar' }

  def symbolize_keys
    dup = {}
    self.each {|k, v| dup[k.to_sym] = v }
    dup
  end

  # The +#symbolize_keys!+ method converts string hash keys into symbols.
  # It is a destructive method; the original hash is changed when this
  # method is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was already
  # deprecated by the time ReactiveSupport was introduced. For that reason,
  # it is being included as part of ReactiveExtensions.
  #
  # Examples:
  #     orig = { 'foo' => 'bar' }
  #     orig.symbolize_keys!
  #
  #     orig      #=> { :foo => 'bar' }

  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end

    self
  end

  # The +#stringify_keys+ method returns a hash identical to the calling
  # hash, but with symbol keys turned into strings. It is non-destructive;
  # the original hash is still available after it is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was
  # already deprected by the time ReactiveSupport was introduced. For
  # that reason, it is being included as part of ReactiveExtensions.
  #
  # Examples: 
  #     orig = { :foo => 'bar' }
  #     dup = orig.stringify_keys
  # 
  #     orig      #=> { :foo => 'bar' }
  #     dup       #=> { 'foo' => 'bar' }

  def stringify_keys
    dup = {}
    self.each {|k, v| dup[k.to_s] = v }
    dup
  end

  # The +#stringify_keys!+ method converts symbol hash keys into strings.
  # It is a destructive method; the original hash is changed when this
  # method is called.
  #
  # Although this method was formerly a part of ActiveSupport, it was already
  # deprecated by the time ReactiveSupport was introduced. For that reason,
  # it is being included as part of ReactiveExtensions.
  #
  # Examples:
  #     orig = { :foo => 'bar' }
  #     orig.symbolize_keys!
  #
  #     orig      #=> { 'foo' => 'bar' }

  def stringify_keys!
    keys.each do |key|
      self[(key.to_s rescue key) || key] = delete(key)
    end

    self
  end
end