# This file was originally in src/part1/classification_and_summarization_using_classifier_gem.rb

module SiEngine
  class ClassifierAndSummarization
    def classify_plain_text(text)
      @bayes.classify(text)
    end

    def train(file_and_topic_list)
      topic_names = file_and_topic_list.collect {|x| x.last}
      @bayes = Classifier::Bayes.new(*topic_names)
      file_and_topic_list.each do |file, category|
        text = File.new(file).read
        @bayes.train(category, text)
      end
    end

    def get_summary(text)
      text.summary(2).gsub(' [...]', '.')
    end

    def classify_and_summarize_plain_text(text)
      [classify_plain_text(text), get_summary(text)]
    end
  end
end

# test = SiEngine::ClassifierAndSummarization.new
# test.train([["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/computers.txt", "Computers"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/economy.txt", "Economy"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/health.txt", "Health"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/software.txt", "Software"]])
# pp test.classify_plain_text("Heart attacks and strokes kill too many people every year.")
# pp test.classify_plain_text("Economic warfare rich versus the poor over international monetary fund.")
# pp test.classify_plain_text("My IBM PC broke so I bought an HP.")
# text = File.new("#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/health.txt").read[0..700]
# puts text
# puts "** classification and summary:"
# pp test.classify_and_summarize_plain_text(text)
