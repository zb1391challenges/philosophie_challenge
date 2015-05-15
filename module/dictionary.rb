module TweetSec
  module Dictionary
    DICTIONARY_PATH = File.expand_path("en.txt")
    
    def english_word?(word)
      open(DICTIONARY_PATH) do |f|
        f.grep(/^#{word}$/).any?
      end
    end

  end
end