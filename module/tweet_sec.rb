require_relative './tweet_sec/tweet_sec'
require_relative './tweet_sec/dictionary'

module TweetSec
  def evaluate!(password)
    TweetSec.new(password).evaluate
  end
end