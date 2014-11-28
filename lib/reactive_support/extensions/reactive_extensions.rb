
# The ReactiveExtensions module consists of methods I wish ActiveSupport provided.
# These methods do not adhere to the ActiveSupport API. If you wish to include
# them in your project, you will need to put this in your main project file:
#     require 'reactive_support/extensions'
#
# ReactiveExtensions includes ReactiveSupport, so you will need to remove any 
# requires for ReactiveSupport as it will raise a SystemStackError.

module ReactiveExtensions
  Dir['./lib/reactive_support/extensions/*.rb'].each {|f| require f }
end