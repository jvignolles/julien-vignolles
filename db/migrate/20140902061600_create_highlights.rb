class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights, :force => true do |t|
      t.boolean  :active,                      :default => true,   :null => false
      t.string   :name,         :limit => 50,  :default => "",     :null => false
      t.string   :url,                           :limit => 128, :default => '',         :null => false
      t.string   :description,  :limit => 255, :default => "",     :null => false
      t.integer  :position,                    :default => 0,      :null => false
      t.timestamps :null => false
    end

    add_index :highlights, :name
    add_index :highlights, :position
    add_index :highlights, :created_at
  end
end
