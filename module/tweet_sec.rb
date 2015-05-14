module TweetSec
  def evaluate(password)
    TweetSec.new(password)
  end

  class TweetSec
    attr_reader :password

    def initialize(password)
      @password = password
    end

  end
end