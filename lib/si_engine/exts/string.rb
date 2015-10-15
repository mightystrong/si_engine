# Please refer to Chapter 2, pages 25-26. Instead of extending the entire Ruby
# String class, a SiEngine::String class was created, which inherits all String
# behavior and is extended with the following methods.

module SiEngine
  class String < String
    def each_char_with_index_and_current_token
      @current_token ||= ''
      @index ||= 0
      self.each_char do |ch|
        if ch == ' '
          @current_token = ''
        else
          @current_token += ch
        end
        @index += 1
        yield(ch, @index, @current_token)
      end
    end

    # Split from one to two methods. See valid_character.
    # From src/part1/remove_noise_characters.rb
    # To test run:
    # path = "#{SiEngine::Engine.root}/app/assets/docs/noise.txt"
    # resource = PlainTextResource.new(path)
    # resource.to_s.remove_noise_characters
    def remove_noise_characters
      ret = ''
      self.each_char do |ch|
        ret << (String.valid_character?(ch) ? ch : '')
      end
      ret.split.join(' ')
    end

    # Split from one to two methods. See remove_noise_characters.
    # From src/part1/remove_noise_characters.rb
    def self.valid_character?(ch)
      return true if ch >= 'a' and ch <= 'z'
      return true if ch >= 'A' and ch <= 'Z'
      return true if ch >= '0' and ch <= '9'
      # allow punctuation errors
      return true if [' ', '.', ',', ';', '!'].index(ch)
      return false
    end
  end
end
