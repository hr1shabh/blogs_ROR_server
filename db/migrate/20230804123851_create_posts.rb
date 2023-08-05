class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :topic, null: false
      t.string :featured_image
      t.text :text, null: false
      t.datetime :published_datetime
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
