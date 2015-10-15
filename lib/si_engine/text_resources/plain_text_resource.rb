# This class was originally included in one file; see src/part1/text-resource.rb
# The various classes have been broken down into separate files for readability.
# Classes: [TextResource, PlainTextResource, BinararyPlainTextResource,
# =>        HtmlXhtmlResource, OpenDocumentResource, RssResource, AtomResource,
# =>        ClassifierAndSummarization, ClassifierWordCountStatistics,
# =>        ClassifierWordCountStatistics, SentimentOfText, EntityExtraction]

module SiEngine
  class PlainTextResource < TextResource
    def initialize(source_uri='')
      super(source_uri)
      file = open(source_uri)
      @plain_text = cleanup_plain_text(file.read)
      process_text_semantics!(@plain_text) # Added the !. Missing from original file.
    end
  end
end
