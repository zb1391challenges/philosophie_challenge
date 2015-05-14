module TweetSec
  def evaluate(password)
    TweetSec.new(password)
  end

  class TweetSec
    attr_reader :password

    def initialize(password)
      @password = password
    end

    def random_letter
      rand(97..122).chr
    end

    def replace_words_with_single_letter
      password.gsub(/([a-zA-Z]{2,})/,random_letter)
    end

  end
end