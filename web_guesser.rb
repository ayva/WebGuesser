require 'sinatra'
require 'sinatra/reloader'

set :SECRET_NUMBER, rand(100)

def check_guess(guess_num)
  if guess_num == SECRET_NUMBER
     "The secret number is #{SECRET_NUMBER}"
  elsif params["guess"].to_i > SECRET_NUMBER
    guess_num - SECRET_NUMBER > 5 ?  "Way too high!" :  "Too high!"
  else 
    SECRET_NUMBER - guess_num > 5 ?  "Way too low!" :  "Too low!"
  end

end

get '/' do
  erb :index, :locals=> {:number => SECRET_NUMBER, :message => '', :guess_num => nil}
end

post '/' do
  guess_num=params["guess"].to_i
  message=check_guess(guess_num)
  erb :index, :locals=> {:number => SECRET_NUMBER, :message => message, :guess_num =>guess_num}
end

