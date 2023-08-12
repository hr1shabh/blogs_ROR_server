class AddViewCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :view_count, :integer
  end
end
