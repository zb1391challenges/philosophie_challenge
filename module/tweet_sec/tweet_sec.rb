require_relative './dictionary'
module TweetSec
  class TweetSec

    attr_reader :password, :character_counts, :password_strength

    def initialize(password)
      @password = password.dup
      @character_counts = {letter_count: 0, number_count: 0, space_count: 0
      }
    end

    def formatted_password
      @formatted_password ||= replace_words_with_single_letter
    end

    def evaluate
      get_character_counts
      @character_counts.select!{|key,value| value > 0}
      @password_strength = formatted_password.length*@character_counts.keys.count
    end
    
    def get_character_counts
      @character_counts[:letter_count]  = character_count(/[a-zA-Z]/)
      @character_counts[:number_count]  = character_count(/\d/)
      @character_counts[:space_count]   = character_count(/\s/)
      @character_counts[:special_count] = formatted_password.length - character_sum
    end
   
    private

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
        res.sub!("#{match}",random_letter) if TweetSec::Dictionary::english_word?(match)
      end
      res
    end
  end
end