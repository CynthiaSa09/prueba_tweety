class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  
  def create
    if already_liked?
      flash[:notice] = "Acabas de dar un like"
    else
      @tweet.likes.create(user_id: current_user.id)
    end
    redirect_to root_path(@tweet)
  end
  
  def destroy
    if !(already_liked?)
      flash[:notice] = "Delete unlike"
    else
      @like.destroy
    end
    redirect_to root_path(@tweet)
  end

  def find_like
    @like = @tweet.likes.find(params[:id])
  end
  
  
  private
  def already_liked?
    Like.where(user_id: current_user.id, tweet_id:
    params[:tweet_id]).exists?
  end
  
  def find_post
    @tweet = Tweet.find(params[:tweet_id])
  end
end






