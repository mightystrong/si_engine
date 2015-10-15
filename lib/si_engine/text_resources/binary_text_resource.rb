# This class was originally included in one file; see src/part1/text-resource.rb
# The various classes have been broken down into separate files for readability.
# Classes: [TextResource, PlainTextResource, BinararyPlainTextResource,
# =>        HtmlXhtmlResource, OpenDocumentResource, RssResource, AtomResource,
# =>        ClassifierAndSummarization, ClassifierWordCountStatistics,
# =>        ClassifierWordCountStatistics, SentimentOfText, EntityExtraction]

module SiEngine
  class BinaryTextResource < TextResource
    def initialize(source_uri='')
      puts "++ enterd BinararyPlainTextResource constructor"
      super(source_uri)
      file = open(source_uri)
      text = file.read
      text = remove_noise_characters(text)
      text = remove_words_not_in_spelling_dictionary(text)
      @plain_text = cleanup_plain_text(text)
      process_text_semantics!(@plain_text) # Added the !. Missing from original file.
    end

    def remove_noise_characters(text)
      text # stub: will be implemented in chapter 2
    end

    def remove_words_not_in_spelling_dictionary(text)
      text # stub: will be implemented in chapter 2
    end
  end
end
