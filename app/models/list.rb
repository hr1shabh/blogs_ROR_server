class List < ApplicationRecord
  belongs_to :user
  has_many :list_items
  has_many :posts, through: :list_items
end
