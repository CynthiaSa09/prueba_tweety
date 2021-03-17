class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  

  validates :content, presence: true
  
  delegate :profile_photo, to: :user, prefix: :true
end
