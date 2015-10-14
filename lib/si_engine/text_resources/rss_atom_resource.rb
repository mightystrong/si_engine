# This class was originally included in one file; see src/part1/text-resource.rb
# The various classes have been broken down into separate files for readability.
# Classes: [TextResource, PlainTextResource, BinararyPlainTextResource,
# =>        HtmlXhtmlResource, OpenDocumentResource, RssResource, AtomResource,
# =>        ClassifierAndSummarization, ClassifierWordCountStatistics,
# =>        ClassifierWordCountStatistics, SentimentOfText, EntityExtraction]

module SiEngine
  # Due to duplication in the classes, and the capability of feedjira to parse
  # RSS and Atom feeds, the RssResource and AtomResource classes have been
  # combined.
  class RssAtomResource < TextResource
    def initialize
      super('')
    end

    # This method has been refactored to use feedjira
    # See http://feedjira.com/
    def self.get_entries(source_uri="")
      entries = []
      items = Feedjira::Feed.fetch_and_parse(source_uri).entries
      items.each do |i|
        content = i.content
        entry = new
        entry.plain_text = entry.cleanup_plain_text(content)
        entry.process_text_semantics!(entry.plain_text)
        entry.source_uri = i.id || ''
        entry.title = i.title || ''
        entries << entry
      end
      entries
    end
  end
end
