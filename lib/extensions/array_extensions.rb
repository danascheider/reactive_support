class Array
  
  # The +#scope+ method is called on an array of hashes. It returns a sub-array
  # including only hashes for which the given +key+ equals the given +value+.
  # The +#scope+ method is non-destructive; the original array will remain intact
  # after it is called. The +#scope+ method is known to work for string or symbol
  # keys. It should work for other data type keys as well.
  #
  # Example:
  #     array = [
  #       { name: 'Jean-Paul Sartre', nationality: 'French' },
  #       { name: 'Bertrand Russell', nationality: 'English' },
  #       { name: 'Ludwig Wittgenstein', nationality: 'Austrian' },
  #       { name: 'Albert Camus', nationality: 'French' }
  #     ]
  # 
  #     array.scope(:nationality, 'French')
  #       # => [
  #              { name: 'Jean-Paul Sartre', nationality: 'French' },
  #              { name: 'Albert Camus', nationality: 'French' }
  #            ]

  def scope(key, value)
    self.reject {|hash| hash[key] != value }
  end
end