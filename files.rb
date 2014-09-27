module ReactiveSupport
  def self.files
    Files::FILES.flatten
  end

  module Files
    LIB_FILES  = Dir.glob('./lib/**/*.rb').sort
    BASE_FILES = %w(CONTRIBUTING.md 
                    files.rb 
                    LICENSE 
                    Gemfile 
                    README.md 
                    reactive_support.gemspec 
                    version.rb)
    SPEC_FILES = Dir.glob('./spec/**/*.rb').sort

    FILES = [BASE_FILES, LIB_FILES, SPEC_FILES]
  end
end