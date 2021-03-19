class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy create_rd ]
  before_action :authenticate_user!
  
  # GET /tweets or /tweets.json
  def index
    if params[:content].present?
      @tweets = Tweet.where("content ilike ?", "%#{ params[:content] }%").page(params[:page]).per(50)
    else 
     friends_ids = current_user.friends.pluck(:friend_id)
      @tweets = Tweet.for_me(friends_ids).order(created_at: :desc).page(params[:page]).per(50)
    end
  
    
    @tweet = Tweet.new
  end
  
  def like
    if current_user
      @tweet = Tweet.find(params[:tweet_id])
      if is_liked?
        @tweet.remove_like(current_user)
      else
        @tweet.add_like(current_user)
      end
    else
      redirect_to new_user_session_path
    end
    redirect_to root_path
  end
  
  # GET /tweets/1 or /tweets/1.json
  def show
    @users = User.all
  end

  def hashtags
    tag = Tag.find_by(name: params[:name])
    @tweets = tag.tweets
  end

  
  # GET /tweets/new
  def new
    @tweet = Tweet.new
    @users = User.pluck :profile_photo, :id
  end
  
  # GET /tweets/1/edit
  def edit
  end
  
  def create_rt
    if current_user
      @tweet = Tweet.find(params[:id])
      Tweet.create(content: @tweet.content , user_id: current_user.id, retweet_id: @tweet.id)
    else 
      redirect_to new_user_session_path
    end
    redirect_to root_path
  end
  

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))
    @tweet.user_id = current_user.id
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        @tweet.erros.each do |error|
          puts error.full_message
        end
        format.html { render root_path, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    if @tweet.user.id == current_user.id
      respond_to do |format|
        if @tweet.update(tweet_params)
          format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
          format.json { render :show, status: :ok, location: @tweet }
        else
          format.html { render :edit }
          format.json { render json: @tweet.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to tweets_path, notice: 'Only admins or the user who created the story can update'
    end
  end

   # DELETE /tweets/1 or /tweets/1.json
    def destroy
      @tweet.destroy
      respond_to do |format|
        format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    private
    def is_liked?
      Like.where(user: current_user.id, tweet:params[:tweet_id]).exists?
    end
    # Use callbacks to share common setup or constraints between actions.
    
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :image, :tweet, :tweet_id, :origin_tweet)
    end
    
end
  