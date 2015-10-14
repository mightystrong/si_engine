source 'https://rubygems.org'

# Declare your gem's dependencies in si_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

# Social Intelligence Gems
# ========================
# These dependencies were found throughout the chapters and the README.txt files
# provided in downloadable code at http://www.apress.com. At the time of this
# writing (October 13, 2015), the direct links were:
# Book - http://www.apress.com/9781430223511
# File - http://www.apress.com/downloadable/download/sample/sample_id/340/

# Book Examples for PART 1
# ------------------------
#
# Required gems:
#
# gem install nokogiri stemmer classifier simplehttp clusterer simple-rss atom rubyzip --no-rdocs --no-ri
#
# If you want to use the spelling example, you will need to install the ASpell utilities
# if they are not already on your system. Run the command "aspell" to see if it is
# already installed; if not, here is a link: http://aspell.net/man-html/Installing.html
#
# On Mac OS X, you can install the MacPorts utility, then do:
# sudo port install aspell
#
# On most Linu systems, you can install ASpell using:
#
# apt-get install aspell
# sudo port install aspell-dict-en

gem 'ruby-stemmer' # Replaces stemmer, which is not maintained.
# Aspell for spell checking: https://github.com/YorickPeterse/ffi-aspell
# At the time the book was written, no gem was available for aspell
gem 'ffi-aspell'
# gem 'classifier'
# gem 'simplehttp'
# gem 'clusterer'
gem 'simple-rss' # May switch to feedjira
# gem 'atom'
gem 'rubyzip'

# Chapter 1 - See src/part1/README.txt
# Included: [rubygems, nokogiri and open-uri]
# Required in ./si_engine.rb
