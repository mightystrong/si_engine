# This was originally in src/part1/sentiment-of-text.rb

module SiEngine
  class SentimentOfText
    def initialize
      @classifier = ClassifierWordCountStatistics.new
      @classifier.train([["#{SiEngine::Engine.root}/app/assets/docs/data/positive.txt", "Positive sentiment"],
                         ["#{SiEngine::Engine.root}/app/assets/docs/data/negative.txt", "Negative sentiment"]])
    end

    def get_sentiment(text)
      @classifier.get_sentiment(text)
    end
  end
end

# st = SiEngine::SentimentOfText.new
# pp st.get_sentiment("the boy kicked the dog")
# pp st.get_sentiment("the boy greeted the dog")
