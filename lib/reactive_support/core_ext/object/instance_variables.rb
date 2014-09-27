class Object 
    # The +#instance_values+ method returns a hash mapping all the calling object's
  # instance variable names to the variables' values. The hash keys are the 
  # variables' names, as strings, without the '@' prepended to them. Each of the
  # hash's values is the value corresponding to the given variable name.
  #
  #     class Widget
  #       def initialize(x,y)
  #         @x, @y = x, y
  #       end
  #     end
  #     
  #     widget = Widget.new('foo', 'bar')
  #     widget.instance_values              # => {'x' => 'foo', 'y' => 'bar'}

  def instance_values
    Hash[instance_variables.map {|name| [name[1..-1], instance_variable_get(name) ] }]
  end

  # The +#instance_variable_names+ method returns an array of the names of 
  # the instance variables defined on the calling object. The names themselves
  # are returned as strings and, unlike in the +#instance_values+ method, 
  # include the +'@'+ prefix.
  #
  #     class Widget
  #       def initialize(x,y)
  #         @x, @y = x, y
  #       end
  #     end
  #
  #     widget = Widget.new(1, 2)
  #     widget.instance_variable_names    # => ['@x', '@y']

  def instance_variable_names
    instance_variables.map {|name| name.to_s }
  end
end