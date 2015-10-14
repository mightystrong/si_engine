# This class was originally included in one file; see src/part1/text-resource.rb
# The various classes have been broken down into separate files for readability.
# Classes: [TextResource, PlainTextResource, BinararyPlainTextResource,
# =>        HtmlXhtmlResource, OpenDocumentResource, RssResource, AtomResource,
# =>        ClassifierAndSummarization, ClassifierWordCountStatistics,
# =>        ClassifierWordCountStatistics, SentimentOfText, EntityExtraction]

module SiEngine
  class HtmlXhtmlResource < TextResource
    def initialize(source_uri="")
      super(source_uri)
      # parse HTML:
      doc = Nokogiri::HTML(open(source_uri))
      @plain_text = cleanup_plain_text(doc.inner_text)
      @headings_1 = doc.xpath('//h1').collect { |h| h.inner_text.strip }
      @headings_2 = doc.xpath('//h2').collect { |h| h.inner_text.strip }
      @headings_3 = doc.xpath('//h3').collect { |h| h.inner_text.strip }
      process_text_semantics!(@plain_text)
    end
  end
end
