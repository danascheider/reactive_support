module ReactiveSupport
  def self.gem_version
    Gem::Version.new Version::STRING
  end

  module Version
    MAJOR = '0'
    MINOR = '5'
    PATCH = '0'
    PRE   = ''

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join('.').chomp('.')
  end
end