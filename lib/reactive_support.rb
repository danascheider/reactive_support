module ReactiveSupport
  def try(method, *args)
    begin
      self.send(method, *args)
    rescue NoMethodError, Sequel::ValidationFailed, Sequel::HookFailed, Sequel::Error
      nil
    end
  end
end

# Include ReactiveSupport in Ruby's +Object+ class. This enables ReactiveSupport
# methods to be called on any Ruby object without explicit inclusion.

class Object
  include ReactiveSupport
end