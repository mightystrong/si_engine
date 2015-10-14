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
