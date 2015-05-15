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
      replaced = to_replace.dup
      replaced[replaced.length/2] = replacement
      @password.sub!(to_replace,replaced)
    end
  end
end