class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string   :email,         :limit => 128, :null => false
      t.string   :kind,                         :null => false
      t.string   :token,         :limit => 10
      t.datetime :confirmation
      t.datetime :revocation
      t.timestamps :null => false
    end

    add_index :subscriptions, :email
    add_index :subscriptions, :token
    add_index :subscriptions, :created_at
  end
end
