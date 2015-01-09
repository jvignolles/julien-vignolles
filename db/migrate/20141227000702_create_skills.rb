class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills, :force => true do |t|
      t.boolean  :active,                                       :default => true,       :null => false
      t.string   :name,                          :limit => 128, :default => '',         :null => false
      t.string   :title,                         :limit => 128, :default => '',         :null => false
      t.text     :description
      t.string   :seo_title,                     :limit => 128, :default => '',         :null => false
      t.string   :seo_h1,                        :limit => 128, :default => '',         :null => false
      t.string   :seo_description,               :limit => 255, :default => '',         :null => false
      t.text     :seo_keywords
      t.integer  :position,                                     :default => 0,          :null => false
      t.timestamps :null => false
    end

    add_index :skills, :name
    add_index :skills, :position
    add_index :skills, :created_at
  end
end
