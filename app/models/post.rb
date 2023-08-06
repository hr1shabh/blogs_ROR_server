class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :bookmarks
  has_many :list_items
  has_many :lists, through: :list_items
  def draft?
    status == "draft"
  end
  enum status: { draft: "draft", published: "published" }
end
