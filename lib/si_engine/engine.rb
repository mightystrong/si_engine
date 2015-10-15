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

    VALID_WORD_HASH = {}
    DICTIONARY_WORDS = File.new("#{SiEngine::Engine.root}/app/assets/docs/big.txt").read.downcase.scan(/[a-z]+/)
    SiEngine::Engine::DICTIONARY_WORDS.each { |word| VALID_WORD_HASH[word] = true }
    TOKENS_TO_IGNORE = ('a'..'z').collect {|tok| tok if !['a', 'i'].index(tok)} + ['li', 'h1', 'h2', 'br'] - [nil]
  end
end
