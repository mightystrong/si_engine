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
    end

    # This was split from the initialize method.
    def text_from_html
      # parse HTML:
      doc = Nokogiri::HTML(open(@source_uri))
      @plain_text = cleanup_plain_text(doc.inner_text)
      @headings_1 = doc.xpath('//h1').collect { |h| h.inner_text.strip }
      @headings_2 = doc.xpath('//h2').collect { |h| h.inner_text.strip }
      @headings_3 = doc.xpath('//h3').collect { |h| h.inner_text.strip }
      process_text_semantics!(@plain_text)
      self
    end

    # This was ported from the src/part1/xml-text-extract-nokogiri.rb file.
    # To test run:
    # path = "#{SiEngine::Engine.root}/app/assets/docs/test.xml"
    # resource = SiEngine::HtmlXhtmlResource.new(path).text_from_xml
    def text_from_xml
      doc = Nokogiri::XML(open(@source_uri))
      @plain_text = doc.text.gsub("\n", ' ').gsub("\t", ' ').split.join(' ')
      @plain_text = cleanup_plain_text(@plain_text)
      self
    end

    # This was ported from the src/part1/xml-text-extract.rb file.
    # To test run:
    # path = "#{SiEngine::Engine.root}/app/assets/docs/test.xml"
    # resource = SiEngine::HtmlXhtmlResource.new(path).text_from_rexml
    def text_from_rexml
      doc = REXML::Document.new(File.new(@source_uri))
      @plain_text = ''
      doc.each_recursive do |element|
        @plain_text << element.text.strip << ' ' if element.text
        @plain_text << element.attributes.values.join(' ').strip << ' '
      end
      @plain_text = cleanup_plain_text(@plain_text)
      self
    end
  end
end
