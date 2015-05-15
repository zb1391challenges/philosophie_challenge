# philosophie_challenge

The goal of this challenge was to create a password evaluator. I created a module called TweetSec to judge a password based on the following rules:

1. Replace any complete English words in the text with any lower-case letter,
preferring longer replacements. For example, given `12password34` we should
replace the full word 'password' rather than replacing 'pass' or 'sword'.
1. Find the number of 'character types' represented in the updated text.
Character types include:
  * alphabet (A-Z, a-z)
  * digits (0-9)
  * whitespace (spaces, tabs, newline characters)
  * other (punctuation, unicode characters, etc.)
1. Multiply the number of represented character types by the length of
the updated text to arrive at a numerical 'strength' value.

# Installation
```
$ bundle install
$ rspec
```

# Usage
```bash
$ ruby main.rb # you will be prompted to enter a password
Enter a password:
test123 test123
# weak
I suggest te!t123 te t123

```

# Implementation
the evaluation process creates an instance of the `TweetSec` class. This object holds data about the given password and the types of characters within it. It follows the ruleset above by first replacing any occurrance of an english word with a single, random letter. It checks for english words against the dictionary file held in en.txt. Once the password is in a proper format, it multiplies the length of the new password by the number of each type of character present, which are found by a series of regular expressions. This numerical value is compared to determine the proper message to return.

## Why there are two failing tests?
as of right now, there are two failing tests, that both regard the same password s0_0per 5nak3. The score on the assignment sheet said it should return a 52. I think this is wrong based off of my understanding of the project. The only way to get a 52 is to multiply 13*4. Since there are 13 characters in s0_0per 5nak3, this is suggesting that the password cannot be broken down, but the 'per' is recognized as an english word according to my dictionary. My score is shown as as a 44 because 'per' is replaced with a single char making the string count equal 11. 

# Replacement Algorithm
the goal of the replacement algorith is to try to make a strong password by only changing characters in the given password. It will then add additional characters if it needs to. My attempt to achieve this result was to first try to split the english words in the password. These english words are significant because in the evaluation process only account for a single letter, regardless of how long that english word actually is. (that is to say the word 'him' and the word 'washington' both are transformed into a single character through the evaluation process). 

The algorithm will therefore look for sequences of 3+ letters. It will then find the middle character of the string and replace it with the minimal character_type. The minimal character_type is type defined above that has the fewest occurances in the current password. (if password is 'test123!', the minimal character_type is a whitespace. therefore the suggested password would become 'te t123' which not only adds an additional letter to the evaluated password but an additional character type ). This process recursively continues until a strong password is returned.

## What I would improve
I ran out of time, and probably ran over the timelimit near the end. Currently the algorithm only suggests the 4 same characters. It will only suggest adding a 'z'. a '5', a whitespace, or a '!'. I would have liked to get a smarter replacement system in place. Maybe create a hash that maps the letter 'l' -> 1 and 'o' -> 0. It just wouldve taken more time to do which I didnt have.