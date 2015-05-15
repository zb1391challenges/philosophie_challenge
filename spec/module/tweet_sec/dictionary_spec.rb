require_relative '../../../module/tweet_sec'
require 'pry'
include TweetSec

describe 'TweetSec::Dictionary' do
  describe '#english_word?' do
    context 'valid english word' do
      it 'returns true' do
        expect(TweetSec::Dictionary.english_word?('apple')).to eq(true)
      end
    end

    context 'invalid english word' do
      it 'returns false' do
        expect(TweetSec::Dictionary.english_word?('asdasdrrr')).to eq(false)
      end
    end
  end
end