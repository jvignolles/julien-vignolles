class AddContactsActiveToConfigurations < ActiveRecord::Migration
  def change
    add_column :configurations, :contacts_active, :boolean, :null => false, :default => false
  end
end

