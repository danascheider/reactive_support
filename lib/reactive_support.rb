module ReactiveSupport
  def try(method, *args)
    begin
      self.send(method, *args)
    rescue NoMethodError, Sequel::ValidationFailed, Sequel::HookFailed, Sequel::Error
      nil
    end
  end
end

class Object
  include ReactiveSupport
end