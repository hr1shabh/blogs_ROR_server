class AddSubscriptionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscription, :string, default: 'none'
  end
end
