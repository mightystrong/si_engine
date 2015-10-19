# This class was originally included the file src/part1/classifier_word_count_statistics.rb

module SiEngine
  class ClassifierWordCountStatistics
    def initialize
      @category_names = []
      @category_wc_hashes = []
      @noise_words = ['the', 'a', 'at', 'he', 'she', 'it', 'is'] # added 'is'
    end

    def classify_plain_text(text)
      word_stems = text.downcase.scan(/[a-z]+/)
      scores = Array.new(@category_names.length)
      @category_names.length.times  do |i|
        scores[i] = score(@category_wc_hashes[i], word_stems)
      end
      @category_names[scores.index(scores.max)]
    end

    def train(file_and_topic_list)
      file_and_topic_list.each do |file, category|
        words = File.new(file).read.downcase.scan(/[a-z]+/)
        hash = Hash.new(0)
        words.each { |word| hash[word] += 1 unless @noise_words.index(word) }
        scale = 1.0 / words.length
        hash.keys.each { |key| hash[key] *= scale }
        @category_names << category
        @category_wc_hashes << hash
      end
    end

    private
      def score(hash, word_list)
        score = 0
        word_list.each do |word|
          score += hash[word]
        end
        1000.0 * score / word_list.size
      end
  end
end

#test = SiEngine::ClassifierWordCountStatistics.new
#test.train([["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/computers.txt", "Computers"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/economy.txt", "Economy"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/health.txt", "Health"],
#            ["#{SiEngine::Engine.root}/app/assets/docs/wikipedia_text/software.txt", "Software"]])
#require 'pp'
#pp test.classify_plain_text("Heart attacks and strokes kill too many people every year.")
