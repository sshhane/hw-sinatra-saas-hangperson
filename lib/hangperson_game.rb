class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses, :guess

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @guess = ''
  end
  
  def guess(letter)
    # make sure the letter is actually a letter
    if letter == nil || !(letter.class == String && letter =~ /^[A-z]$/i)
      raise ArgumentError
    end
    # handle different cases
    letter.downcase!
    
    # handle repeated guesses
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    
    #handle case where guess is not a letter
    # return false if letter.length != 1
    
    # check guess
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
    return true

  end
  
  def word_with_guesses
    wwg=''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        wwg += letter
      else
        wwg += '-'
      end
    end
    wwg
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
