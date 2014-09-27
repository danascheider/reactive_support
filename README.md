## ReactiveSupport [![Gem Version](https://badge.fury.io/rb/reactive_support.svg)](http://badge.fury.io/rb/reactive_support) [![Build Status](https://travis-ci.org/danascheider/reactive_support.svg?branch=master)](https://travis-ci.org/danascheider/reactive_support) [![Coverage Status](https://img.shields.io/coveralls/danascheider/reactive_support.svg)](https://coveralls.io/r/danascheider/reactive_support) [![Code Climate](https://codeclimate.com/github/danascheider/reactive_support/badges/gpa.svg)](https://codeclimate.com/github/danascheider/reactive_support) [![Inline docs](http://inch-ci.org/github/danascheider/reactive_support.svg?branch=master)](http://inch-ci.org/github/danascheider/reactive_support)
The ReactiveSupport gem provides a re-implementation of certain [ActiveSupport](https://github.com/rails/activesupport)
methods, allowing them to be used outside of the Rails ecosystem. This gem can 
be used in any kind of project and is not dependent on any frameworks, gemsets, etc.
To add ReactiveSupport to your project, add this to your Gemfile and run `bundle install`:
<pre><code>gem 'reactive_support', '~> 0.1.2'</code></pre>
To install locally:
<pre><code>sudo gem install reactive_support</code></pre>
Or if you're using RVM: 
<pre><code>gem install reactive_support</code></pre>
Then, in your main project file, include:
<pre><code>require 'reactive_support'</code></pre>

You can also point your Gemfile to this repo:
<pre><code>gem 'reactive_support', '~> 0.1.2', git: 'https://github.com/danascheider/reactive_support.git</code></pre>

If you would like to install an earlier version, you can specify that version's branch
using the standard branch naming scheme:
<pre><code>gem 'reactive_support', '~> 0.1.2', git: 'https://github.com/danascheider/reactive_support.git, branch: 'version-0.1.2'</code></pre>

Please note that version 0.1.2 is the earliest available version of ReactiveSupport.

### Usage
In its current version, ReactiveSupport adds methods to Ruby's `Object` class, so
once required, its methods can be used on any object within your project, including
core Ruby classes.

Currently, ReactiveSupport's methods are a strict subset of ActiveSupport's. (This may 
change in future versions, or most saliently, if ActiveSupport's API changes.)
That means that, while not all ActiveSupport methods are available, those that are can,
as of September 2014, be found in ActiveSupport's API documentation with no functional
differences. (This is true of ReactiveSupport 0.1.0 and ActiveSupport 4.1.6.)

### FAQ
##### Why not just use ActiveSupport?
There are three main reasons why you might prefer ReactiveSupport over ActiveSupport:
  1. Stability: ReactiveSupport is intended to work independently of Rails' rapidly changing 
     ecosystem. ReactiveSupport methods are guaranteed not to be transferred to other
     Rails modules or refactored out. While ActiveSupport may be used independently of
     Rails, its developers are still primarily focused on its place within Rails.
     ReactiveSupport solves that problem.
  2. Simplicity: ReactiveSupport can be added to other projects without additional abstraction
     layers, and it has no dependencies outside the development and test groups. You
     don't have to worry about configuration, compatibility with other gems*, or
     conflicting dependencies.
  3. Transparency: Rails is an enormous gem, and gets larger and more complex with each major version.
     It is also opinionated, facilitating some development approaches while making
     others inordinately difficult. ReactiveSupport is not large or complicated. Any
     developer can read the documentation, or even the code itself, and know exactly what
     he or she is dealing with.

\* I would not recommend using it in conjunction with ActiveSupport, though.

##### This doesn't have very many methods. What gives?
ReactiveSupport is a spinoff from my other project, [Canto](https://github.com/danascheider/canto).
Consequently, the methods it includes are primarily those that I have found a use for 
in Canto. As Canto grows, and as I have time, I will add more of ActiveSupport's 
numerous useful methods to ReactiveSupport. In the meantime, I welcome contributions
and will respond quickly to pull requests.

##### Is ReactiveSupport being maintained?
Yes. Since stability is one of the main advantages of ReactiveSupport, I will be taking
an "if it ain't broke, don't fix it" approach to maintaining it. An absence of recent
contributions should not be taken to mean it has fallen off my radar.

##### Can I use ReactiveSupport in a Sinatra project/Puppet module/system utility/etc.?
Yes. ReactiveSupport is agnostic to the characteristics of your app, and there is no
reason it cannot be used in any app where you feel it will be useful.

##### What versions of Ruby are supported?
ReactiveSupport version 0.1 supports Ruby versions >= 1.9.3. Additional Rubies
may be supported in the future. Adding such support would be a welcome contribution
to the project.

### Contributing
Contributions are welcome and I will respond promptly to all issue reports and pull
requests. Here are some guidelines to get started; I also encourage you to read the 
full CONTRIBUTING.md file to ensure your pull request will be accepted as is:
  * Include passing RSpec tests with your pull request. I aim for 100% test coverage.
  * Run the whole test suite before you make your PR. Make sure your changes don't
    break the rest of the gem.
  * Make sure your changes are consistent with the functionality of ActiveSupport.
    Users should be able to learn about a ReactiveSupport method by reading the 
    ActiveSupport docs for the corresponding ActiveSupport method.
  * Don't add any new dependencies to ReactiveSupport, or methods that are specific
    to a particular framework, gemset, or type of app.
  * Include documentation. ReactiveSupport uses [Inch CI](http://inch-ci.org) to
    evaluate the quality of documentation. Please help make it easy for others to
    use and contribute to this project.
  * Keep ReactiveSupport principles - stability, simplicity, and transparency - in mind.
    Ideally, contributions should uphold these principles while expanding or 
    enhancing functionality.

### Resources
  * The [Rails guides](http://guides.rubyonrails.org/active_support_core_extensions.html) on
    ActiveRecord give information about each of ReactiveSupport's methods.
  * Those interested in contributing to ReactiveSupport are encouraged read up on 
    [Travis CI](http://travis-ci.org), [Coveralls](http://coveralls.io), 
    [CodeClimate](http://codeclimate.com), and [Inch CI](http://inch-ci.org).
  * Check out ReactiveSupport at [Rubygems.org](http://rubygems.org/gems/reactive_support)!