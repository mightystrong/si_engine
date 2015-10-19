# This file was originally found in src/part1/entity_extraction.rb
# Constants have been moved into the ../engine.rb file.

module SiEngine
  class EntityExtraction
    def initialize(text = '')
      words = text.scan(/[a-zA-Z]+/)
      word_flags = Array.new(words.length)
      words.each_with_index do |word, i|
        word_flags[i] = []
        word_flags[i] << SiEngine::Engine::PLACE_STRING_TO_SYMBOLS[SiEngine::Engine::PLACE_NAMES[word]] if SiEngine::Engine::PLACE_NAMES[word]
        word_flags[i] << :first_name  if SiEngine::Engine::FIRST_NAMES[word]
        word_flags[i] << :last_name   if SiEngine::Engine::LAST_NAMES[word]
        word_flags[i] << :prefix_name if SiEngine::Engine::PREFIX_NAMES[word]
      end

      # easier logic with two empty arrays at end of word flags:
      word_flags << [] << []

      # remove :last_name if also :first_name and :last_name token nearby:
      word_flags.each_with_index do |flags, i|
        if flags.index(:first_name) && flags.index(:last_name)
          if word_flags[i+1].index(:last_name) || word_flags[i+2].index(:last_name)
            word_flags[i] -= [:last_name]
          end
        end
      end

      # look for middle initials in names:
      words.each_with_index do |word, i|
        if word.length == 1 && word >= 'A' && word <= 'Z'
          if word_flags[i-1].index(:first_name) && word_flags[i+1].index(:last_name)
            word_flags[i] << :middle_initial if word_flags[i].empty?
          end
        end
      end

      # discard all but :prefix_name if followed by a name:
      word_flags.each_with_index  do |flags, i|
        if flags.index(:prefix_name)
          word_flags[i] = [:prefix_name] if human_name_symbol_in_list?(word_flags[i+1])
        end
      end

      #discard two last name tokens in a row if the preceeding token is not a name token:
      word_flags.each_with_index  do |flags, i|
        if i<word_flags.length-2 && !human_name_symbol_in_list?(flags) && word_flags[i+1].index(:last_name) && word_flags[i+2].index(:last_name)
          word_flags[i+1] -= [:last_name]
        end
      end

      # discard singleton name flags (with no name flags on either side):
      word_flags.each_with_index do |flags, i|
        if human_name_symbol_in_list?(flags)
          unless human_name_symbol_in_list?(word_flags[i+1]) || human_name_symbol_in_list?(word_flags[i-1])
            [:prefix_name, :first_name, :last_name].each do |name_symbol|
              word_flags[i] -= [name_symbol]
            end
          end
        end
      end

      @human_names = []
      human_name_buffer = []
      @place_names = []
      place_name_buffer = []
      in_place_name = false
      in_human_name = false
      word_flags.each_with_index do |flags, i|
        human_name_symbol_in_list?(flags) ? in_human_name = true : in_human_name = false
        if in_human_name
          human_name_buffer << words[i]
        elsif !human_name_buffer.empty?
          @human_names << human_name_buffer.join(' ')
          human_name_buffer = []
        end
        place_name_symbol_in_list?(flags) ? in_place_name = true : in_place_name = false
        if in_place_name
          place_name_buffer << words[i]
        elsif !place_name_buffer.empty?
          @place_names << place_name_buffer.join(' ')
          place_name_buffer = []
        end
      end
      @human_names.uniq!
      @place_names.uniq!
    end

    def human_names
      @human_names
    end

    def place_names
      @place_names
    end

    def human_name_symbol_in_list?(a_symbol_list)
      a_symbol_list.each {|a_symbol|
        return true if [:prefix_name, :first_name, :middle_initial, :last_name].index(a_symbol)
      }
      false
    end

    def place_name_symbol_in_list?(a_symbol_list)
      a_symbol_list.each do |a_symbol|
        return true if SiEngine::Engine::PLACE_STRING_SYMBOLS.index(a_symbol)
      end
      false
    end

    # Ported from src/part1/find_common_names.rb and changed to a class method
    # of the EntityExtraction class.
    # Not sure if this was the best place to put it but it seemed to be the
    # most appropriate. (From pg. 63-64)
    def self.find_common_names(*file_paths)
      names_texts = file_paths.map { |file_path| File.new(file_path).read }
      extractors = names_texts.map { |file_path| self.new(file_path) }

      names_lists = extractors.map { |extractor| extractor.human_names }
      common_names = names_lists.pop
      names_lists.each { |nlist| common_names = common_names & nlist }

      places_lists = extractors.map { |extractor| extractor.place_names }
      common_places = places_lists.pop
      places_lists.each { |nlist| common_places = common_places & nlist }

      [common_names, common_places]
    end
  end
end

# test = SiEngine::EntityExtraction.new('President George W. Bush left office and Barack Obama was sworn in as president and went to Florida with his family to stay at Disneyland.')
# pp test.human_names
# pp test.place_names

# See pg. 63-64
# barack = "#{SiEngine::Engine.root}/app/assets/docs/test_data/wikipedia_barack_obama.txt"
# hillary = "#{SiEngine::Engine.root}/app/assets/docs/test_data/wikipedia_hillary_clinton.txt"
# results = SiEngine::EntityExtraction.find_common_names(barack, hillary)
# => [["Barack Obama", "John McCain"], ["Chicago", "Iraq", "Illinois", "Washington", "Columbia", "World"]]
