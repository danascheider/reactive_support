## Contributing to ReactiveSupport
ReactiveSupport is a small project with only one maintainer (nice to meet you),
so your contributions are much appreciated. Here are some guidelines to improve 
the chances your pull request will be accepted.

#### Summary Guidelines
The more of these guidelines you read, the more likely it is your pull request
will be accepted. That said, here is the TL;DR version. (Details are available in 
later sections.)

DO...
  * Expand existing functionality
  * Fix bugs
  * Add or improve tests and documentation
  * Feel free to add new files as needed(make sure to add them to the
    gemspec too!)
  * Keep everything consistent with the ActiveSupport API
  * Include robust, passing RSpec examples with your PR
  * Include extensive [RDoc](https://github.com/rdoc/rdoc) comments
  * Keep your code DRY and concise - be mindful of best practices
  * Familiarize yourself with the metrics, vision, and values of this project
  * Run the full test suite before making your PR
  * File an issue report or message me if you have any questions
    (I don't bite!)

DON'T...
  * Worry that your pull request is too small - all improvements are welcome
  * Break backward compatibility
  * Modify existing functionality (unless required to fix a bug)
  * Add dependencies
  * Add functionality that is not present in ActiveSupport (except to the 
    ReactiveExtensions module)
  * Submit a PR with breaking changes or no passing tests
  * Submit changes that only work with particular tools, gemsets, 
    environments, or with only a subset of supported Ruby versions.

Thank you for your contributions!

#### Types of Contributions
I'll consider all contributions, but the following would be 
particularly helpful.

##### Issue Reports
Issue reports need not adhere to the rest of the contributing guidelines.
I welcome questions, problems, and feature requests (i.e., ActiveSupport
functionality you'd like to see in this gem) and will respond promptly in
most cases. When reporting a problem or bug, please include as much 
information as possible, including the following:
  * Version of ReactiveSupport and other tools in your project
  * Version(s) of Ruby you're using or testing against
  * Code samples and error messages you're getting
  * What you have already tried
  * Any additional information relevant to your particular problem

##### Bug fixes
If you find a bug affecting ReactiveSupport's interaction with other gems,
frameworks, tools, platforms, rubies, or environments, your issue report
or patch is much appreciated. If your fix has to do with Rails, you will
also need to explain why ReactiveSupport would be included in a Rails project
since I can't think of a reason.

##### Additional ActiveSupport methods
Most of the ActiveRecord methods I'm including are those that I find directly
relevant to [my other project](https://github.com/danascheider/canto). I
encourage pull requests that add methods that would be useful to you or others.

##### Additional or improved tests or docs
ReactiveSupport uses RSpec and RDoc for testing and documentation, respectively.
Improvements in coverage or quality of tests and documentation are very helpful.

#### Project Vision
Your pull request is more likely to be successful if you keep ReactiveSupport's 
vision and values in mind. This gem is:

##### Unopinionated, agnostic, and independent
ReactiveSupport is intended to provide additional, useful functionality to all 
Ruby developers. Successful pull requests will work regardless of platform,
environment, tooling, or gemsets, and will do so without adding dependencies.

##### Stable and compatible
ReactiveSupport exists so users can have access to ActiveSupport's useful methods
without relying on Rails, whose frequent changes and reorganizations can hurt 
projects relying on its components. Changes you submit must not adversely affect
backwards compatibility or break existing functionality. **This is the single most 
important rule for contributing to ReactiveSupport.** 

##### Functionally identical to ActiveSupport
A person should be able to learn about a ReactiveSupport method by reading the 
ActiveSupport documentation on the corresponding method. Note that this rule
is subordinated to the previous one. Stability and compatibility come first, always.

##### Test-driven and test-first
ReactiveSupport development is guided by the principles of behavior-driven
development. Look at existing spec files and notice how many examples are included
for each method. Test coverage is measured by [Coveralls](http://coveralls.io), 
and 100% coverage by robust, detailed tests is the standard for this project.

##### Well documented
[Inch CI](http://inch-ci.org) is being used to evaluate the thoroughness of 
ReactiveSupport's [RDoc](https://github.com/rdoc/rdoc) documentation.
Please include detailed documentation with your pull request.

##### Mindful of metrics
As a perfectionistic and slightly neurotic individual, I have configured the
following tools for evaluating different aspects of the ReactiveSupport gem.
Please familiarize yourself with them:
  * **[Travis CI](https://travis-ci.org)** is used to ensure all tests pass. 
    Commits that break Travis builds make me a 
    [sad panda](http://www.urbandictionary.com/define.php?term=sad+panda). 
  * **[Coveralls](https://coveralls.io)** is used to evaluate extent of 
    test coverage. The goal is 100% coverage, which is an achievable goal.
  * **[CodeClimate](http://codeclimate.com)** is used to evaluate code 
    quality. I consider a CodeClimate score below 3.5 unacceptably low for
    this project. (You can easily check your fork before submitting.)
  * **[Inch CI](http://inch-ci.org)** is used to evaluate documentation.
    Don't worry too much about what Inch says (it's newish and buggy), but 
    *do* take the time to include quality docs.

#### Style Guide
Development of ReactiveSupport is guided by best practices. This is a simple
gem and it should be DRY, concise, and thoroughly documented.
Here are some of the best practices and stylistic guidelines I like my projects
to adhere to:
  * `unless` is preferred to `if not`
  * Single-line blocks use curly braces
  * Multi-line blocks use `do`...`end` syntax
  * Single quotes are preferred to double quotes when there's a choice
  * Fewer lines good, more lines bad (see below for examples)
  * More files are better than large files*
  * RSpec `describe` and `context` blocks are good
  * RSpec `let` syntax is good
  * RSpec examples should have a single point of failure

And here are some smells to avoid (may be OK in some cases):
  * One RSpec example has multiple points of failure
  * A value is hard-coded
  * A method is more than 3 lines long or contains nested conditionals or blocks

Note that monkey patching is NOT considered a smell in ReactiveSupport as long
as it solves a problem not solved within the ReactiveSupport module itself.

\* But don't forget to update the gemspec!

##### Examples: Fewer lines good, more lines bad
Lots of things can be reduced to a single line, especially blocks and conditionals.

    # This:
    array.map do |num|
      puts "#{num} is now #{num + 1}"
      num += 1
    end

    # Should be turned into this:
    array.map {|item| puts "#{item} is now #{item += 1}" }

    # And this: 
    if foo.defined?
      puts "It's defined!"
    else 
      puts "It's not defined!"
    end

    # Should look more like this:
    puts foo.defined? ? "It's defined!" : "It's not defined!"

    # And finally, this: 
    begin
      return message = foo.message
    rescue 
      "It didn't work"
    end

    # Needs to be written like this:
    return foo.message rescue "It didn't work!"

#### Contributing to ReactiveExtensions
The ReactiveExtensions module is for useful methods that are not included in
ActiveSupport, but are congruent with its spirit. I'll accept additions to 
ReactiveExtensions as long as they will be useful to a broad audience and
adhere to best practices and style/testing/documentation guidelines.