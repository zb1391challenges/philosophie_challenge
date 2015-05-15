module TweetSec
  module Dictionary
    DICTIONARY_PATH = File.expand_path("en.txt")
    @@dictionary = {}

    def dictionary
      @@dictionary.keys.any? ? @@dictionary : create_dictionary
    end

    def english_word?(word)
      dictionary[word] || false
    end

    def create_dictionary
      File.open(DICTIONARY_PATH).each do |line|
        @@dictionary[line.strip] = true
      end
      @@dictionary
    end

  end
end