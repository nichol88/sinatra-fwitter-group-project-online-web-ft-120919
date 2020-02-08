class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
    if @tweet.errors.any?
      redirect '/tweets/new'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do

    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.update(params[:tweet])
    if @tweet.errors.any?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? and @tweet.user_id == current_user.id
      
      @tweet.delete
    else
      redirect '/login'
    end
  end

end
