require 'sinatra'
require 'sinatra/reloader'

set :SECRET_NUMBER, rand(100)

  @@track=5

def check_guess(guess_num)
  secret=settings.SECRET_NUMBER 
  puts @@track
  if guess_num == secret
      settings.SECRET_NUMBER=rand(100)
      @@track=5
     ["Congratulations! You've guessed. The secret number is #{secret}", '6BAE4B']
  elsif @@track==1
      settings.SECRET_NUMBER=rand(100) 
      @@track=5
      return ["I'm sorry, you've lost. A new number was generated.", 'white']
  elsif params["guess"].to_i > secret
    @@track-=1
    guess_num - secret > 5 ?  ["Way too high!", 'C95757'] :  ["Too high!", 'FFBCBC']
  else 
    @@track-=1
    secret - guess_num > 5 ?  ["Way too low!",'C95757'] :  ["Too low!",'FFBCBC']
  end
  
end



get '/' do
  cheat=params["cheat"]
  erb :index, :locals=> {:number => settings.SECRET_NUMBER, :message => '', :back_color => 'white', :cheat => cheat}
end

post '/' do
  cheat=params["cheat"]
  guess_num=params["guess"].to_i
  message=check_guess(guess_num)
  erb :index, :locals=> {:number => settings.SECRET_NUMBER, :message => message[0], :back_color => message[1],:cheat => cheat}
end

