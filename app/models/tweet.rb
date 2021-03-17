class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :tweets
  

  validates :content, presence: true
  
  delegate :profile_photo, to: :user, prefix: :true
end
