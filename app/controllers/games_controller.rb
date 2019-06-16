# frozen_string_literal: true

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @start_time = Time.now.to_s.gsub(/\s+/, '')
    @letters = []
    vowels = ['A', 'E', 'O', 'U', 'I']
    2.times { @letters << vowels.sample }
    8.times { @letters << ('A'..'Z').to_a.sample }
    @string = @letters.shuffle.join('')
  end

  def check_word
    @word.each do |letter|
      return false if @grid.count(letter.upcase) < @word.count(letter)
    end
    true
  end

  def score
    @word = params[:word].split('')
    @start_time = Time.parse(params[:start_time].chomp("/").insert(10, ' ').insert(-5, ' '))
    @total_time = Time.now - @start_time
    @grid = params[:letters].split('')
    @grid.delete_at(-1)

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = open(url).read
    answer = JSON.parse(user_serialized)
    if answer['found']
      if check_word
        @score = "congratulations! #{params[:word].upcase} is a valid english word.
        Your total score is #{(100 * (@word.length / @total_time).round(2))}"
      else
        @score = "Sorry but #{params[:word].upcase} can't be built out of the letters #{@grid.join(', ')} "
      end
      # @time = Time.now - params[:start_time]
    else @score = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    end
  end
end
