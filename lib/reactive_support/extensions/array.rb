# The ReactiveExtensions module consists of methods I wish ActiveSupport provided.
# These methods do not adhere to the ActiveSupport API. If you wish to include
# them in your project, you will need to put this in your main project file:
#     require 'reactive_support/extensions'

module ReactiveExtensions
  Dir['./lib/reactive_support/extensions/array/*.rb'].each {|f| require f }
end