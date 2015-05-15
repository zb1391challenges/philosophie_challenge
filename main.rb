require_relative './module/tweet_sec'

include TweetSec

puts 'Enter a password:'
STDOUT.flush  
password = gets.chomp

res = evaluate!(password)
puts res
if res == 'weak'
  puts "I suggest #{suggest_alternative(password)}"
end