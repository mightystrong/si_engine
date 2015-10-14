# This class was originally included in one file; see src/part1/text-resource.rb
# The various classes have been broken down into separate files for readability.
# Classes: [TextResource, PlainTextResource, BinararyPlainTextResource,
# =>        HtmlXhtmlResource, OpenDocumentResource, RssResource, AtomResource,
# =>        ClassifierAndSummarization, ClassifierWordCountStatistics,
# =>        ClassifierWordCountStatistics, SentimentOfText, EntityExtraction]

module SiEngine
  class TextResource
    attr_accessor :source_uri
    attr_accessor :plain_text
    attr_accessor :title
    attr_accessor :headings_1
    attr_accessor :headings_2
    attr_accessor :headings_3
    attr_accessor :sentence_boundaries
    attr_accessor :categories
    attr_accessor :place_names
    attr_accessor :human_names
    attr_accessor :summary
    attr_accessor :sentiment_rating # [-1..+1]  positive number implies positive sentiment

    def initialize source_uri=''
      puts "++ entered TextResource constructor"
      @source_uri = source_uri
      @title = ''
      @headings_1 = []
      @headings_2 = []
      @headings_3 = []
    end

    # Originally one method. Now two. See remove_extra_whitespace.
    def cleanup_plain_text(text)
      text.gsub!('>', '> ')
      if text.index('<') && text.index('>') # probably HTML
        # Originally HTML::FullSanitizer.new.sanitize(text)
        text = Rails::Html::FullSanitizer.new.sanitize(text)
      end
      remove_extra_whitespace(text)
    end

    # Originally one method. Now two. See cleanup_plain_text.
    def remove_extra_whitespace(text)
      text = text.gsub(/\s{2,}|\t|\n/,' ') # Peter's suggestion
      text
    end

    # Before uncommenting this method.
    # TODO: Add wikipedia_text files for training
    # TODO: Add ClassifierAndSummarization class
    # TODO: Add EntityExtraction class
    # TODO: SentimentOfText class
    def process_text_semantics! text
    #   cs = ClassifierAndSummarization.new
    #   cs.train([['wikipedia_text/computers.txt', "Computers"],
    #            ['wikipedia_text/economy.txt', "Economy"],
    #            ['wikipedia_text/health.txt', "Health"],
    #            ['wikipedia_text/software.txt', "Software"]])
    #   results = cs.classify_and_summarize_plain_text(@plain_text)
    #   @categories = results[0]
    #   @summary = results[1]
    #   @summary = @title + ". " + @summary if @title.length > 1
    #   @sentence_boundaries = get_sentence_boundaries(@plain_text)
    #   ee = EntityExtraction.new(@plain_text)
    #   @human_names = ee.human_names
    #   @place_names = ee.place_names
    #   st = SentimentOfText.new
    #   @sentiment_rating = st.get_sentiment(@plain_text)
    end
  end
end
