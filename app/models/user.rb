class User < ApplicationRecord
  has_many :posts 
  has_many :comments
  has_many :likes
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followed_relationships, class_name: 'Relationship', foreign_key: 'followed_id'
  has_many :bookmarks
  has_many :bookmarked_posts, through: :bookmarks, source: :post
  has_many :lists

  pay_customer stripe_attributes: :stripe_attributes
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower
  
  # New methods to get followers count and following count
  def followers_count
    followers.count
  end

  def following_count
    following.count
  end

  def stripe_attributes(pay_customer)
    {
      address: {
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id # or pay_customer.owner_id
      }
    }
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
