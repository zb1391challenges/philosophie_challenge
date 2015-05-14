require_relative '../module/tweet_sec'

include TweetSec

describe 'TweetSec' do
  describe 'evaluate' do
    it 'returns a TweetSec object' do
      expect((evaluate('')).class).to eq(TweetSec::TweetSec)
    end
  end
end