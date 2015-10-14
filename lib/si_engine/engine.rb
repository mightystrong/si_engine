require "open-uri"
require "nokogiri"
require "lingua/stemmer" # gem ruby-stemmer
require "ffi/aspell" # gem ffi-aspell
require "zip"

module SiEngine
  class Engine < ::Rails::Engine
    isolate_namespace SiEngine
  end
end
