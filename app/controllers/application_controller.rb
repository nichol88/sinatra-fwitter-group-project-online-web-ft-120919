#require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'potatoes'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
     if logged_in?
       redirect '/tweets'
     end
    erb :signup
  end

  post '/signup' do
    @user = User.create(params)
    if @user.errors.any?
      redirect '/signup'
    else
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    redirect "/tweets" if logged_in?
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user and @user.authenticate params[:password]
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      "#{@user.errors.full_messages.to_sentence}"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/tweets'
    end
  end

  post 'logout' do
    session.clear
    redirect '/login'
  end

  helpers do
    def current_user
      User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

  end

end
