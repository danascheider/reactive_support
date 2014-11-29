# This file adds the +#transform_keys+, +#transform_keys!+,
# +#stringify_keys+, +#stringify_keys!+, +#symbolize_keys+, and 
# +#symbolize_keys! methods to Ruby's core +Hash+ class. These
# methods modify the hash's keys according to given parameters,
# or create a duplicate with keys modified in this way.

# Ruby's core Hash class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Hash.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Hash.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Hash.html].

class Hash

  # The +#assert_valid_keys method validates that all keys in a hash 
  # match +*valid_keys+, raising an ArgumentError if the keys don't
  # match. Note that, as usual, symbols and strings are treated as 
  # distinct.
  #
  # Examples:
  #     {:foo => 'bar'}.assert_valid_keys(:foo)         # => true
  #     {:foo => 'bar'}.assert_valid_keys(:foo, :baz)   # => true
  #     {:foo => 'bar'}.assert_valid_keys(:baz)         # => ArgumentError
  #     {:foo => 'bar'}.assert_valid_keys('foo')        # => ArgumentError

  def assert_valid_keys(*valid_keys)
    valid_keys.flatten!
    each_key do |key|
      unless valid_keys.include?(key) 
        raise ArgumentError.new("Unknown key: #{key.inspect}. Valid keys are: #{valid_keys.map(&:inspect).join(', ')}")
      end
    end
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
    transform_keys &:to_s
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
    transform_keys! &:to_s
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
    transform_keys {|key| key.to_sym }
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
    transform_keys! {|key| key.to_sym }
  end

  # The +#transform_keys+ method returns a new hash with all keys transformed
  # in accordance with the given +block+. The +#transform_keys+ method is 
  # non-destructive; the original hash will still be available after it is 
  # called.
  #
  # If no block is given, the method returns an enumerator. 
  # 
  # Example:
  #     hash = { :foo => 'bar' }
  #     hash.transform_keys {|key| key.to_s.upcase }      # => { 'FOO' => 'bar' }
  #     hash.transform_keys                               # => #<Enumerator: {:foo=>"bar"}:transform_keys>
  #     hash                                              # => { :foo => 'bar' }

  def transform_keys(&block)
    return enum_for(:transform_keys) unless block_given?
    dup = self.class.new 

    each_key do |key|
      dup[yield key] = self[key]
    end

    dup
  end

  # The +#transform_keys!+ method transforms all of the calling hash's keys
  # in accordance with the given +block+. The +#transform_keys!+ method is 
  # destructive; the original hash will be changed in place after it is 
  # called.
  #
  # If no block is given, the method returns an enumerator. 
  # 
  # Example:
  #     hash = { :foo => 'bar' }
  #     hash.transform_keys! {|key| key.to_s.upcase }     # => { 'FOO' => 'bar' }
  #     hash.transform_keys!                              # => #<Enumerator: {:foo=>"bar"}:transform_keys!>
  #     hash                                              # => { 'FOO' => 'bar' }

  def transform_keys!(&block)
    return enum_for(:transform_keys) unless block_given?

    keys.each do |key|
      self[yield key] = delete(key)
    end

    self
  end
end