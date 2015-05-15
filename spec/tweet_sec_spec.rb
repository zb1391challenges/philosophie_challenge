require_relative '../module/tweet_sec'
require 'pry'

include TweetSec

describe 'TweetSec' do
  describe '#evaluate!' do
    describe 'password is password1' do
      it 'returns 4' do
        expect(evaluate!('password1')).to eq('unacceptable')
      end
    end
    
    describe 'password is goat m4n' do
      it 'returns 4' do
        expect(evaluate!('goat m4n')).to eq('weak')
      end
    end
    
    describe 'password is s0_0per 5nak3' do
      it 'returns 52' do
        expect(evaluate!('s0_0per 5nak3')).to eq('strong')
      end
    end
  end

  describe '#strength' do
    context 'less than or equal to 10' do
      it 'returns "unacceptable"' do
        expect(strength(10)).to eq('unacceptable')
        expect(strength(0)).to eq('unacceptable')
      end
    end

    context 'greater than 10 and less than 50' do
      it 'returns "weak"' do
        expect(strength(11)).to eq('weak')
        expect(strength(49)).to eq('weak')
      end
    end

    context 'greater than or equal to 50' do
      it 'returns "strong"' do
        expect(strength(50)).to eq('strong')
        expect(strength(55)).to eq('strong')
      end
    end
  end

  describe '#suggest_alternative' do
    describe 'fewest space characters' do
      it 'test' do
        res = suggest_alternative('test test123')
        binding.pry
      end
    end
  end
end

