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
  end
end
