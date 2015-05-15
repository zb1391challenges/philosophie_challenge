module TweetSec

  def evaluate!(password)
    TweetSec.new(password).evaluate
  end

  class TweetSec

    DICTIONARY_PATH = File.expand_path("en.txt")

    attr_reader :password, :character_counts, :password_strength

    def initialize(password)
      @password = password
      @character_counts = {letter_count: 0, number_count: 0, space_count: 0}
    end

    def formatted_password
      @formatted_password ||= replace_words_with_single_letter
    end

    def evaluate
      get_character_counts
      @character_counts.select!{|key,value| value > 0}
      @password_strength = formatted_password.length*@character_counts.keys.count
    end

    private
    
    def get_character_counts
      @character_counts[:letter_count]  = character_count(/[a-zA-Z]/)
      @character_counts[:number_count]  = character_count(/\d/)
      @character_counts[:space_count]   = character_count(/\s/)
      @character_counts[:special_count] = formatted_password.length - character_sum
    end

    def character_sum
      @character_counts.values.inject{|sum, val| sum+val}
    end

    def character_count(regex)
      formatted_password.scan(regex).count
    end

    def random_letter
      rand(97..122).chr
    end

    def replace_words_with_single_letter
      res = password
      password.scan(/[a-zA-Z]{2,}/).each do |match|
        res.sub!("#{match}",random_letter) if english_word?(match)
      end
      res
    end

    def english_word?(word)
      open(DICTIONARY_PATH) do |f|
        f.grep(/^#{word}$/).any?
      end
    end

  end
end