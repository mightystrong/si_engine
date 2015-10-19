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
      @plain_text = cleanup_plain_text(text)
      @plain_text = self.to_s.remove_noise_characters
      @plain_text = self.to_s.remove_words_not_in_spelling_dictionary
      process_text_semantics!(@plain_text) # Added the !. Missing from original file.
    end
  end
end

# test = SiEngine::BinaryTextResource.new("#{SiEngine::Engine.root}/app/assets/docs/noise.txt")
# test.plain_text
# => "amp ; . your physician or any information contained on or in any product "
