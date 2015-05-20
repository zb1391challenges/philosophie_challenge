require_relative '../../../module/tweet_sec'
require 'pry'

include TweetSec

describe 'TweetSec::TweetSec' do
  describe 'initialize' do
    let(:tweet_sec) {TweetSec::TweetSec.new('test')}
    
    it 'stores the password' do
      expect(tweet_sec.password).to eq('test')
    end

    it 'initializes character_counts' do
      expect(tweet_sec.character_counts[:letter_count]).to eq(0)
      expect(tweet_sec.character_counts[:number_count]).to eq(0)
      expect(tweet_sec.character_counts[:space_count]).to eq(0)
    end


  end

  describe '#replace_words_with_single_letter' do
    it "replaces 'password' with a single letter" do
      tweet_sec = TweetSec::TweetSec.new('password')
      expect(tweet_sec.send(:replace_words_with_single_letter).length).to eq(1)
    end

    it 'replaces every sequence of 2 or more chars with a single letter' do
      tweet_sec = TweetSec::TweetSec.new('pass word password')
      expect(tweet_sec.send(:replace_words_with_single_letter).length).to eq(5)
    end
  end

  describe '#get_character_counts' do
    describe 'password uses a combination of all types' do
      let(:tweet_sec) {TweetSec::TweetSec.new("_he11o 12E_")}

      before do
        tweet_sec.get_character_counts
      end
      
      it 'sets letter_count to 3' do
        expect(tweet_sec.character_counts[:letter_count]).to eq(3)
      end

      it 'sets number_count to 4' do
        expect(tweet_sec.character_counts[:number_count]).to eq(4)
      end

      it 'sets space_count to 1' do
        expect(tweet_sec.character_counts[:space_count]).to eq(1)
      end

      it 'sets special_count to 2' do
        expect(tweet_sec.character_counts[:special_count]).to eq(2)
      end
    end
  end

  describe '#evaluate' do
    describe 'password is only special characters' do
      let(:tweet_sec) {TweetSec::TweetSec.new("&!_")}

      before do
        tweet_sec.evaluate
      end

      it 'removes space_count from the character_counts hash' do
        expect(tweet_sec.character_counts[:space_count]).to eq(nil)
      end

      it 'removes letter_count from the character counts hash' do
        expect(tweet_sec.character_counts[:letter_count]).to eq(nil)
      end

      it 'removes number_count from the character counts hash' do
        expect(tweet_sec.character_counts[:number_count]).to eq(nil)
      end
    end

    describe 'password does not have special characters' do
      let(:tweet_sec) {TweetSec::TweetSec.new("hello123")}

      before do
        tweet_sec.evaluate
      end

      it 'removes special_count from the character_counts hash' do
        expect(tweet_sec.character_counts[:special_count]).to eq(nil)
      end
    end

    describe 'password is password1' do
      let(:tweet_sec) {TweetSec::TweetSec.new("password1")}

      before do
        tweet_sec.evaluate
      end

      it 'sets the password_strength to 4' do
        expect(tweet_sec.password_strength).to eq(4)
      end      
    end

    describe 'password is goat m4n' do
      let(:tweet_sec) {TweetSec::TweetSec.new("goat m4n")}

      before do
        tweet_sec.evaluate
      end

      it 'sets the password_strength to 15' do
        expect(tweet_sec.password_strength).to eq(15)
      end      
    end

    describe 'password is s0_0per 5nak3' do
      let(:tweet_sec) {TweetSec::TweetSec.new("s0_0per 5nak3")}

      before do
        tweet_sec.evaluate
      end

      it 'sets the password_strength to 52' do
        expect(tweet_sec.password_strength).to eq(44)
      end      
    end
  end
end