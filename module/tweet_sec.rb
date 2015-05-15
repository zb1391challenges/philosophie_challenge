require_relative './tweet_sec/tweet_sec'
require_relative './tweet_sec/dictionary'

module TweetSec
  def evaluate!(password)
    strength(TweetSec.new(password).evaluate)
  end

  def strength(password_strength)
    if password_strength <= 10
      'unacceptable'
    elsif password_strength < 50
      'weak'
    else
      'strong'
    end
  end

  def suggest_alternative(password)
    tweet_sec = TweetSec.new(password)
    tweet_sec.get_character_counts
    min = tweet_sec.character_counts.min_by{|k,v| v}
    max = tweet_sec.character_counts.max_by{|k,v| v}
    binding.pry
    new_password = replace_password(password, min)
    binding.pry
    if TweetSec.new(new_password).evaluate < 50
      suggest_alternative(new_password)
    else
      new_password
    end
  end

  def replace_password(password, min)
    replacement_suggestions = {
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
    if password.match(/([a-zA-Z]{3,})/)
      replacement = $1.dup
      replacement[replacement.length/2] = replacement_suggestions[min[0]][:replacement]
      password.sub($1,replacement)
    elsif min[1] == 0
      password.sub(replacement_suggestions[max[0]][:regex], replacement_suggestions[min[0]][:replacement])
    else
      password += replacement_suggestions[min[0]][:replacement]
    end
  end
end