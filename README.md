SI Engine (Scripting Intelligence)
==================================
This project is an attempt to port the code from the book [Scripting Intelligence](http://www.apress.com/9781430223511) by Mark Watson into a Ruby on Rails Engine.

Currently, the project only includes code from Part 1 of the book.

Requirements
------------
This application requires:
- Ruby 2.2.3
- Rails 4.2.4

Documentation and Support
-------------------------
SiEngine is mountable. Add `mount SiEngine::Engine => "/si_engine"` to your `config/routes.rb` file.

Environment Variables
---------------------

*Open Calais:*

`=> ENV["open_calais"]`

Get an Open Calais API Key at: <http://new.opencalais.com/>

Create an `open_calais.rb` file in `config/initializers`:

```ruby
require 'open_calais'

OpenCalais.configure do |c|
  c.api_key = "add your key here"
end
```

After setup the following should work:

`$ rails console`

```ruby
client = OpenCalais::Client.new

results = client.enrich('Ruby on Rails is a fantastic web framework. It uses MVC, and the Ruby programming language invented by Matz in Japan.')

=> #<OpenCalais::Response:0x007fae99575ba8...
```

Contributing
------------
[Michael Price](http://www.linkedin.com/in/michaeljohnprice/)

* Twitter: [@michaeljprice](https://twitter.com/michaeljprice)
* Email: <mike@mightystrongmedia.com>

The `develop` branch has been set as the default branch. I use the [git flow](https://github.com/nvie/gitflow) branching model, which is "A collection of Git extensions to provide high-level repository operations for Vincent Driessen's [branching model](http://nvie.com/git-model)."

Please use feature branches, which branch off develop and make pull requests into develop.

If there's a bug found in the master branch, a hotfix may be used to branch off the master. Go to [git flow](https://github.com/nvie/gitflow) to get started.

License
-------
MIT-LICENSE

Licensing as prescribed by the book:

"The software that I have written for this book is all released under one or more open source licenses. My preference is the Lesser General Public License (LGPL), which allows you to use my code in commercial applications without releasing your own code. But note that if you improve LGPL code, you are required to share your improvements. In some of the book's example, I use other people's open source projects, in which cases I will license my example code with the same licenses used by the authors of those libraries."
