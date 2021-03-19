class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  has_many :tweets
  has_many :likes
  has_many :friends

  def is_friend_with(user)
    Friend.where(user_id: self.id, friend_id: user.id).present?
  end

end
