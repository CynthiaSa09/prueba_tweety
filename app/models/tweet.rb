class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweets
  has_many :likes
end
