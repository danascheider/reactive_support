# This file adds the +#transform_keys+ and +#transform_keys!+ methods
# to Ruby's core +Hash+ class. These methods iterate through a hash's
# keys, passing each to a block and changing them accordingly.

class Hash

  # The +#transform_keys+ method returns a new hash with all keys transformed
  # in accordance with the given +block+.
  def transform_keys(&block)
    return enum_for(:transform_keys) unless block_given?
    dup = self.class.new 

    each_key do |key|
      dup[yield key] = self[key]
    end

    dup
  end

  def transform_keys!(&block)
    return enum_for(:transform_keys) unless block_given?

    keys.each do |key|
      self[yield key] = delete(key)
    end
    
    self
  end
end