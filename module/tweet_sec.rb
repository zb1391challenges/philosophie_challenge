require_relative './tweet_sec/tweet_sec'
require_relative './tweet_sec/dictionary'
require_relative './tweet_sec/password_suggester'

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

  def suggest_alternative(password, suggester = nil)
    suggester ||= PasswordSuggester.new(password)
    suggester.replace_password
    if TweetSec.new(suggester.password).evaluate < 50
      suggest_alternative(suggester.password)
    else
      suggester.password
    end
  end
end