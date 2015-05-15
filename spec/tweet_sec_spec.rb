require_relative '../module/tweet_sec'
require 'pry'

include TweetSec

describe 'TweetSec' do
  describe 'evaluate!' do
    describe 'password is password1' do
      it 'returns 4' do
        expect(evaluate!('password1')).to eq(4)
      end
    end
    
    describe 'password is goat m4n' do
      it 'returns 4' do
        expect(evaluate!('goat m4n')).to eq(15)
      end
    end
    
    describe 'password is s0_0per 5nak3' do
      it 'returns 52' do
        expect(evaluate!('s0_0per 5nak3')).to eq(52)
      end
    end
  end
end

