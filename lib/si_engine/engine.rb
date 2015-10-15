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

    # This was ported from src/part1/text-resource.rb and changed slightly.
    # Access with SiEngine::Engine::CONSTANT
    HUMAN_NAME_PREFIXES = ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Sr.', 'Maj.', 'St.', 'Lt.', 'Sen.']
    MONTH_ABBR = ['Jan.', 'Feb.', 'Mar.', 'Apr.', "Jun.", 'Jul.', 'Aug.', 'Sep', 'Oct.', 'Nov.', 'Dec.']
    DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
  end
end
