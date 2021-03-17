class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  belongs_to :retweet, class_name: "Tweet", optional:true

  validates :content, presence: true
  
  delegate :profile_photo, to: :user, prefix: :true

  def add_like(user)
    Like.create(user: user, tweet: self)
  end

  def remove_like(user)
    Like.where(user: user, tweet: self).first.destroy
  end
  
end
