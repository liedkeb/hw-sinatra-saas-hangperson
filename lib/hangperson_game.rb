class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_reader :word
  attr_accessor :guesses, :wrong_guesses

  
  def initialize(word)
    @word = word
    @wrong_guesses=@guesses=''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    # letter =~ /[^a-z]/i
    raise ArgumentError if letter.nil? or letter.empty? or (letter=~/[[:alpha:]]/)==nil 
    letter = letter.downcase
    if word.include?(letter) 
      if guesses.include? letter
        return false
      else
        @guesses += letter
      end
    else
      
      if wrong_guesses.include? letter
        return false
      else
         @wrong_guesses += letter
      end
    end
  end
  
  def word_with_guesses
    # 'hello'.gsub(/[eo]/, '-')
    # word.gsub(/[^"#{guesses}"]/, '-')
    
    out=''
    word.each_char {|let| guesses.include?(let) ? out+=let : out+='-'}
    return out 
  end
  
  def check_win_or_lose
    return :win  if word == word_with_guesses
    return :lose if wrong_guesses.size >= 7
    return :play
  end
end
