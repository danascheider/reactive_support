# Ruby's core Proc class. See documentation for version 
# 2.1.5[http://ruby-doc.org/core-2.1.5/Proc.html],
# 2.0.0[http://ruby-doc.org/core-2.0.0/Proc.html], or 
# 1.9.3[http://ruby-doc.org/core-1.9.3/Proc.html].

class Proc
  def raises_error?(*args)
    (!self.call(*args)) rescue true
  end
end