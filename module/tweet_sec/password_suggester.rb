require_relative './tweet_sec'

module TweetSec
  class PasswordSuggester
    attr_reader :password, :min_type, :min_amount, :tweet_sec

    REPLACEMENT_OPTIONS = {
      letter_count: {
        replacement: 'z',
        regex: /[a-zA-Z]/
      },
      number_count: {
        replacement: '5',
        regex: /\d/
      },
      space_count: {
        replacement: " ",
        regex: /\s/
      },
      special_count: {
        replacement: '!',
        regex: /[^\w\s]/
      }
    }

    def initialize(password)
      @password = password.dup
      @tweet_sec = TweetSec.new(password)
      @tweet_sec.get_character_counts
      min = tweet_sec.character_counts.min_by{|k,v| v}
      @min_type = min[0]
      @min_amount = min[1]
    end

    def regex
      @regex ||= REPLACEMENT_OPTIONS[@min_type][:regex]
    end

    def replacement
      @replacement ||=  REPLACEMENT_OPTIONS[@min_type][:replacement]
    end

    def replace_password
      if @password.match(/([a-zA-Z]{3,})/)
        replace_char_sequence($1)
      elsif @min_amount == 0 
        @password.sub!(regex,replacement)
      else
        @password += replacement
      end
    end

    private 

    def replace_char_sequence(to_replace)
      vowel_stripped_word = find_and_replace_vowels(to_replace)
      @password.sub!(to_replace,vowel_stripped_word)
    end

    def find_and_replace_vowels(word)
      word.gsub(/[aeiou]/){|vowel| vowel_replacements[vowel.downcase]}
    end

    def vowel_replacements
      @vowel_replacements ||= {'a' => '@', 'e' => '3', 'i' => '!', 'o' => '0', 'u' => '^'}
    end

  end
end