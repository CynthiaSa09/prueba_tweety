class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def data
  end

  # GET /tweets or /tweets.json
  def index
    if params[:content].present?
      @tweets = Tweet.where('content = ?', params[:content])
    else
      @tweets = Tweet.all
    end
     @paginated_tweets = Tweet.page(params[:page]).paginate(page: params[:page], per_page: 50)
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
      @tweet = Tweet.new
      @users = User.pluck :profile_photo, :id
    end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))
  

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :image)
    end
  end


