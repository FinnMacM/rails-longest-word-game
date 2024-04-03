class GamesController < ApplicationController
  before_action :set_letters, only: [:score]
  before_action :setup_stats, only: [:new, :score]

  def new
    @letters = ('a'..'z').to_a.sample(10)
    session[:letters] = @letters
  end

  # def score
  #   @word = params[:word].downcase
  #   @message = word_valid?(@word, @letters) ? "a valid input" : "not a valid word"
  # end

  def score
    @word = params[:word].downcase
    if word_valid?(@word, @letters)
      @message = "a valid input"
      session[:valid_count] += 1
      if @word.length > session[:longest_word].length
        session[:longest_word] = @word
      end
    else
      @message = "not a valid word"
    end
  end

  private

  def set_letters
    @letters = session[:letters] || []
  end

  def word_valid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def setup_stats
    session[:valid_count] ||= 0
    session[:longest_word] ||= ""
  end
end
