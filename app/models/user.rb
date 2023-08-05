class User < ApplicationRecord
  has_many :posts 
  has_many :comments
  has_many :likes
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id'

  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower
  
  # New methods to get followers count and following count
  def followers_count
    followers.count
  end

  def following_count
    following.count
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
