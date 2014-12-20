require 'cgi'

class Object

  # Called on a generic object that doesn't implement its own +#to_param+ method, 
  # the +#to_param+ method aliases +#to_s+. Like +#to_s+, it is non-destructive;
  # the original object is not changed when +#to_param+ is called.
  #
  # Examples:
  #     a = 1
  #     a.to_param      # => "1"
  #     a               # => 1

  def to_param
    to_s
  end

  # Called on a generic object that doesn't implement its own +#to_query+ method,
  # the +#to_query+ method generates a string suitable for use as a query string
  # in a URL, using the given +key+ as a param name. Like +#to_param+, +#to_query+
  # is non-destructive; the original object is not changed when it executes.
  #
  # Example:
  #     a = 1 
  #     a.to_param('a')     # => "a%5B%5D=1"
  #     a                   # => 1

  def to_query(key)
    "#{CGI.escape(key.to_param)}=#{CGI.escape(to_param.to_s)}"
  end
end

class NilClass

  # Called on +NilClass+, the +#to_param+ method returns +nil+.

  def to_param
    self
  end
end

class TrueClass

  # Called on +TrueClass+, the +#to_param+ method returns +true+.

  def to_param
    self
  end
end

class FalseClass

  # Called on +FalseClass+, the +#to_param+ method returns +false+.

  def to_param
    self 
  end
end

class Array

  # When called on an array, the +#to_param+ method first calls +#to_param+ on
  # all members of the array, and then joins them into a string separated by 
  # forward slashes. The +#to_param+ method is non-destructive; the original 
  # array and its members are still available after +#to_param+ has been executed.
  #
  # Examples:
  #     array = ['foo', 12, :bar]
  #     array.to_param                # => 'foo/12/bar'
  #     array                         # => ['foo', 12, :bar]

  def to_param
    collect(&:to_param).join('/')
  end

  # When called on an array, the +#to_query+ method converts the array into a 
  # string suitable for use as a query string in a URL, using the given +key+
  # as a param name. The +#to_query method is non-destructive; the original
  # array and its members are still available after the method executes.
  #
  # Examples:
  #     [].to_query('foo')              # => "foo%5B%5D="
  #     ['foo', 'bar'].to_query('baz')  # => "baz%5B%5D=foo&baz%5B%5D=bar"

  def to_query(key)
    prefix = "#{key}[]"

    if empty?
      nil.to_query(prefix)
    else
      collect {|v| v.to_query(prefix) }.join('&')
    end
  end
end

class Hash

  # When called on a hash, the +#to_query+ method returns a string representation
  # of the receiver suitable for use as a URL query string. An optional namespace
  # can be passed to enclose key names. The key-value pairs in the string are sorted
  # lexicographically in ascending order.
  #
  # This method is aliased as +#to_param+.
  #
  # Examples:
  #     h = {:foo => 'bar', :baz => 'qux'}
  #     h.to_query              # => "baz=qux&foo=bar"
  #     h.to_query('norf')      # => "norf%5Bbaz%5D=qux&norf%5Bfoo%5D=bar"
  #     {}.to_query             # => ""

  def to_query(namespace=nil)
    collect do |k,v|
      unless (v.is_a?(Hash) || v.is_a?(Array)) && v.empty?
        v.to_query(namespace ? "#{namespace}[#{k}]" : k)
      end
    end.compact.sort! * '&'
  end

  alias_method :to_param, :to_query
end