class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  belongs_to :retweet, class_name: "Tweet", optional:true
  

  scope :for_me, ->(friends_ids) { where(user_id: friends_ids) }

  validates :content, presence: true
  
  delegate :profile_photo, to: :user, prefix: :true

  def add_like(user)
    Like.create(user: user, tweet: self)
  end

  def remove_like(user)
    Like.where(user: user, tweet: self).first.destroy
  end

  def original_tweet
    Tweet.find(self.origin_tweet)
  end
  
  def create_hashtag
    hashtags = self.content.split(' ')
    new_content = hashtags.map do |hashtag|
    if hashtag.include?('#')
    "<a href='http://localhost:3000/?content=#{hashtag}'>#{hashtag}</a>"
    else 
      hashtag
    end
  end 
    new_content.join(' ').html_safe
  end
end 
    