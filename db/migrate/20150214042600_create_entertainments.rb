class CreateEntertainments < ActiveRecord::Migration
  def change
    create_table :entertainments, :force => true do |t|
      t.boolean  :active,                      :default => true,   :null => false
      t.string   :name,         :limit => 255, :default => "",     :null => false
      t.integer  :position,                    :default => 0,      :null => false
      t.timestamps :null => false
    end

    add_index :entertainments, :name
    add_index :entertainments, :position
    add_index :entertainments, :created_at
  end
end
