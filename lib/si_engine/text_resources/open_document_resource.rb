# This class was originally included in one file; see src/part1/text-resource.rb
# The various classes have been broken down into separate files for readability.
# Classes: [TextResource, PlainTextResource, BinararyPlainTextResource,
# =>        HtmlXhtmlResource, OpenDocumentResource, RssResource, AtomResource,
# =>        ClassifierAndSummarization, ClassifierWordCountStatistics,
# =>        ClassifierWordCountStatistics, SentimentOfText, EntityExtraction]

module SiEngine
  class OpenDocumentResource < TextResource

    class OOXmlHandler
      include StreamListener
      attr_reader :plain_text
      attr_reader :headers

      def tag_start(name, attrs)
        @last_name = name
      end

      def text(s)
        s.strip!
        if @last_name.index('text:h')
          @headers << s if s.length > 0
        end
        if @last_name.index('text') && s.length > 0
          @plain_text << s
          @plain_text << "\n"
        end
      end
    end

    def initialize(source_uri='')
      # Originally Zip::ZipFile.open(source_uri) do |zipFile|
      Zip::File.open(source_uri) do |zipFile|
        xml_h = OOXmlHandler.new
        Document.parse_stream((zipFile.read('content.xml')), xml_h)
        @plain_text = cleanup_plain_text(xml_h.plain_text)
        @headers_1 = xml_h.headers
      end
      process_text_semantics(@plain_text)
    end
  end
end
