require 'open_calais'

OpenCalais.configure do |c|
  # The development version of SiEngine uses figaro and defines this variable
  # in config/application.yml. See cofig/application.yml.example
  # See Figaro: https://github.com/laserlemon/figaro
  c.api_key = ENV["open_calais"]
end

# After setup the following should work:
# $ rails console
# > client = OpenCalais::Client.new
# > results = client.enrich('Ruby on Rails is a fantastic web framework. It uses MVC, and the Ruby programming language invented by Matz in Japan.')
# > => #<OpenCalais::Response:0x007fae99575ba8...
