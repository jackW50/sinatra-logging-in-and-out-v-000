require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    binding.pry 
    @user = User.find_by(username: params[:usename], password: params[:password])
    @user.id = session[:id]
    redirect "/account"
  end

  get '/account' do
    @user = User.find(session[:id])
    if @user == nil
      erb :error
    end 
    erb :account
  end

  get '/logout' do
    session.clear 
    redirect '/'
  end


end

