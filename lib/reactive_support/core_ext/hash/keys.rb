# This file adds the +#transform_keys+ and +#transform_keys!+ methods
# to Ruby's core +Hash+ class. These methods iterate through a hash's
# keys, passing each to a block and changing them accordingly.

class Hash

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