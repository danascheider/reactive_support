class Hash

  # By default, only instances of +Hash+ itself are extractable.
  # Subclasses of +Hash+ may implement this method and return
  # true to declare themselves extractable. +Array#extract_options!+
  # then pops the hash if it comes as the last argument in a set of
  # splat args.

  def extractable_options?
    instance_of? Hash 
  end
end

class Array

  # The +#extract_options!+ method retrieves a hash of options from
  # the end of a set of splat args. If the last element of the set 
  # is +Hash+ or instance of another class implementing the 
  # +#extractable_options?+ method, +#extract_options!+ method pops
  # and returns that object. Otherwise, it returns an empty +Hash+.

  def extract_options!
    return last.is_a?(Hash) && last.extractable_options? ? pop : {}
  end
end