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
end