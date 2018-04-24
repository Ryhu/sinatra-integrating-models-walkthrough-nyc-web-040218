require_relative 'config/environment'
require_relative 'models/text_analyzer.rb'
require 'pry'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    text_from_user = params[:user_text]
    @words = text_from_user.split(' ').length
    split = text_from_user.gsub(/\s+/,'').split('')
    @vowels = split.select do |el|
      ["a", "e", "i", "o", "u"].include?(el.downcase)
    end.length
    @consonants = split.length - @vowels
    @most = ''
    @most_count = 0
    hash = {}
    split.each do |el|
      if hash[el] != nil
        hash[el] += 1
        if hash[el] >= @most_count
          @most_count = hash[el]
          @most = el
        end
      else
        hash[el] = 1
      end
    end

    @most = @most.upcase


    erb :results
  end
end
