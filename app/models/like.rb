class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  def image_like
    user_like = tweet.likes.find{ |like| like.user_id == tweet.likes.user.id_tweet}
  end
  
end
