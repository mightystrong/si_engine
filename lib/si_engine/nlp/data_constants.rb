# These constants were ported from src/part1/entity_extraction.rb

module SiEngine
  class Engine
    PLACE_NAMES = Hash.new
    open("#{SiEngine::Engine.root}/app/assets/docs/data/placenames.txt").readlines.each do |line|
      index = line.index(':')
      PLACE_NAMES[line[0...index].strip] = line[index+1..-1].strip
    end
    ### note: possible values in PLACE_NAME hash:
    #         ["city", "us_city", "country_capital", "country", "us_state"]
    PLACE_STRING_TO_SYMBOLS = { 'city' => :city, 'us_city' => :us_city,
                                'country_capital' => :country_capital,
                                'country' => :country, 'us_state' => :us_state }
    PLACE_STRING_SYMBOLS = PLACE_STRING_TO_SYMBOLS.values

    FIRST_NAMES = Hash.new
    open("#{SiEngine::Engine.root}/app/assets/docs/data/firstnames.txt").readlines.each do |line|
      FIRST_NAMES[line.strip] = true
      puts "first: #{line}" if line.strip.index(' ')
    end

    LAST_NAMES = Hash.new
    open("#{SiEngine::Engine.root}/app/assets/docs/data/lastnames.txt").readlines.each do |line|
      LAST_NAMES[line.strip] = true
      puts "last: #{line}" if line.strip.index(' ')
    end

    PREFIX_NAMES = Hash.new
    open("#{SiEngine::Engine.root}/app/assets/docs/data/prefixnames.txt").readlines.each do |line|
      PREFIX_NAMES[line.strip] = true
      puts "prefix: #{line}" if line.strip.index(' ')
    end
  end
end
