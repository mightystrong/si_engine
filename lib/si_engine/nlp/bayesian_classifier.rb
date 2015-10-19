# This was originally in the file src/part1/classifier_bayesian_using_classifier_gem.rb

module SiEngine
  class BayesianClassifier
    def classify_plain_text text
      @bayes.classify(text)
    end

    def train file_and_topic_list
      topic_names = file_and_topic_list.collect { |x| x.last }
      @bayes = Classifier::Bayes.new(*topic_names)
      file_and_topic_list.each do |file, category|
        text = File.new(file).read
        @bayes.train(category, text)
      end
    end
  end
end

# test = SiEngine::BayesianClassifier.new
# test.train([["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/computers.txt", "Computers"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/economy.txt", "Economy"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/health.txt", "Health"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/software.txt", "Software"]])
# require 'pp'
# pp test.classify_plain_text("Heart attacks and strokes kill too many people every year.")
