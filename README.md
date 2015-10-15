SI Engine (Scripting Intelligence)
---------
This project is an attempt to port the code from the book [Scripting Intelligence](http://www.apress.com/9781430223511) by Mark Watson into a Ruby on Rails Engine.

Requirements
------------
This application requires:
- Ruby 2.2.3
- Rails 4.2.4

Environment Variables
---------------------
TBD

Documentation and Support
-------------------------
SiEngine is mountable. Add `mount SiEngine::Engine => "/si_engine"` to your `config/routes.rb` file.

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
