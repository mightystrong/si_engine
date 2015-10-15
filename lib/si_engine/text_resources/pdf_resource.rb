# This class was NOT originally included in one file; see src/part1/text-resource.rb
# It is a custom class written to handle PDF files within the context of the
# TextResource class using the pdf-reader gem: https://github.com/yob/pdf-reader

module SiEngine
  class PDFResource < TextResource
    def initialize
      super('')
    end

    def self.analyze_pdf(source_uri='')
      file = PDF::Reader.new(source_uri)
      pdf = PDFResource.new
      pdf.plain_text = ""
      file.pages.each do |page|
        pdf.plain_text += pdf.cleanup_plain_text(page.text)
      end
      pdf.process_text_semantics!(pdf.plain_text)
      pdf.source_uri = source_uri || ''
      pdf
    end
  end
end
