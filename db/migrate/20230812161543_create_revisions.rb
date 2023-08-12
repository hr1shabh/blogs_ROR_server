class CreateRevisions < ActiveRecord::Migration[7.0]
  def change
    create_table :revisions do |t|
      t.references :post, null: false, foreign_key: true
      t.string :title
      t.string :topic
      t.text :text
      t.datetime :published_datetime

      t.timestamps
    end
  end
end
