require_relative '../module/tweet_sec'
require 'pry'

include TweetSec

describe 'TweetSec' do
  describe 'evaluate' do
    it 'returns a TweetSec object' do
      expect((evaluate('')).class).to eq(TweetSec::TweetSec)
    end
  end
end

describe 'TweetSec::TweetSec' do
  describe 'initialize' do
    let(:tweet_sec) {TweetSec::TweetSec.new('test')}
    
    it 'stores the password' do
      expect(tweet_sec.password).to eq('test')
    end
  end

  describe 'replace_words_with_single_letter' do
    it "replaces 'password' with a single letter" do
      tweet_sec = TweetSec::TweetSec.new('password')
      expect(tweet_sec.replace_words_with_single_letter.length).to eq(1)
    end

    it 'replaces every sequence of 2 or more chars with a single letter' do
      tweet_sec = TweetSec::TweetSec.new('pass word password')
      expect(tweet_sec.replace_words_with_single_letter.length).to eq(5)
    end
  end
end