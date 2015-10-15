require "open-uri"
require "nokogiri"
require "lingua/stemmer" # gem ruby-stemmer
require "ffi/aspell" # gem ffi-aspell
require "zip"
require "feedjira"
require "rexml/document"
require "rexml/streamlistener"
include REXML
require "pdf/reader"
# require "word-to-markdown" # Optional
require "antiword"
require "ffi/extractor"

module SiEngine
  class Engine < ::Rails::Engine
    isolate_namespace SiEngine
  end
end
