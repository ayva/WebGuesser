require 'sinatra'
require 'sinatra/reloader'

set :SECRET_NUMBER, rand(100)

def check_guess(guess_num)
  secret=settings.SECRET_NUMBER
  if guess_num == secret
     ["The secret number is #{secret}", '6BAE4B']
  elsif params["guess"].to_i > secret
    guess_num - secret > 5 ?  ["Way too high!", 'C95757'] :  ["Too high!", 'FFBCBC']
  else 
    secret - guess_num > 5 ?  ["Way too low!",'C95757'] :  ["Too low!",'FFBCBC']
  end
end

get '/' do
  erb :index, :locals=> {:number => settings.SECRET_NUMBER, :message => '', :back_color => 'white'}
end

post '/' do
  guess_num=params["guess"].to_i
  message=check_guess(guess_num)
  erb :index, :locals=> {:number => settings.SECRET_NUMBER, :message => message[0], :back_color => message[1]}
end

