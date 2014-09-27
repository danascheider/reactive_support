module ReactiveSupport
  def self.gem_version
    Gem::Version.new Version::STRING
  end

  module Version
    MAJOR = '0'
    MINOR = '1'
    PATCH = '1'
    PRE   = 'beta'

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join('.').chomp('.')
  end
end