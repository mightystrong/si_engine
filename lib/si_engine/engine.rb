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
    # Stop words may be found at a new link not referenced in the book:
    # http://ir.dcs.gla.ac.uk/resources/linguistic_utils/stop_words
    STOP_WORDS = [ "a", "about", "above", "across", "after", "afterwards", "again",
      "against", "all", "almost", "alone", "along", "already", "also", "although",
      "always", "am", "among", "amongst", "amoungst", "amount", "an", "and",
      "another", "any", "anyhow", "anyone", "anything", "anyway", "anywhere",
      "are", "around", "as", "at", "back", "be", "became", "because", "become",
      "becomes", "becoming", "been", "before", "beforehand", "behind", "being",
      "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom",
      "but", "by", "call", "can", "cannot", "cant", "co", "computer", "con",
      "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down",
      "due", "during", "each", "eg", "eight", "either", "eleven", "else",
      "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone",
      "everything", "everywhere", "except", "few", "fifteen", "fify", "fill",
      "find", "fire", "first", "five", "for", "former", "formerly", "forty",
      "found", "four", "from", "front", "full", "further", "get", "give", "go",
      "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter",
      "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his",
      "how", "however", "hundred", "i", "ie", "if", "in", "inc", "indeed",
      "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter",
      "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile",
      "might", "mill", "mine", "more", "moreover", "most", "mostly", "move",
      "much", "must", "my", "myself", "name", "namely", "neither", "never",
      "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor",
      "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once",
      "one", "only", "onto", "or", "other", "others", "otherwise", "our",
      "ours", "ourselves", "out", "over", "own", "part", "per", "perhaps",
      "please", "put", "rather", "re", "same", "see", "seem", "seemed",
      "seeming", "seems", "serious", "several", "she", "should", "show",
      "side", "since", "sincere", "six", "sixty", "so", "some", "somehow",
      "someone", "something", "sometime", "sometimes", "somewhere", "still",
      "such", "system", "take", "ten", "than", "that", "the", "their", "them",
      "themselves", "then", "thence", "there", "thereafter", "thereby",
      "therefore", "therein", "thereupon", "these", "they", "thick", "thin",
      "third", "this", "those", "ththth", "three", "through", "throughout",
      "thru", "thus", "to", "together", "too", "top", "toward", "towards",
      "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us",
      "very", "via", "was", "we", "well", "were", "what", "whatever", "when",
      "whence", "whenever", "where", "whereafter", "whereas", "whereby",
      "wherein", "whereupon", "wherever", "whether", "which", "while",
      "whither", "whowhowhoer", "whole", "whom", "whose", "why", "will", "with",
      "within", "without", "would", "yet", "you", "your", "yours", "yourself",
      "yourselves" ]
  end
end
