module ReactiveSupport
  def try(method, *args, &block)
    begin
      block_given? ? self.send(method, *args, &block) : self.send(method, *args)
    rescue
      nil
    end
  end
end

# Include ReactiveSupport in Ruby's +Object+ class. This enables ReactiveSupport
# methods to be called on any Ruby object without explicit inclusion.

class Object
  include ReactiveSupport
end