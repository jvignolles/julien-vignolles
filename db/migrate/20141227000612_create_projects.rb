class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, :force => true do |t|
      t.boolean  :active,                                       :default => true,       :null => false
      t.boolean  :highlight,                                    :default => false,      :null => false
      t.string   :name,                          :limit => 128, :default => '',         :null => false
      t.string   :year,                          :limit => 128, :default => '',         :null => false
      t.string   :website_url,                   :limit => 128, :default => '',         :null => false
      t.text     :description
      t.integer  :job_id
      t.string   :seo_title,                     :limit => 128, :default => '',         :null => false
      t.string   :seo_h1,                        :limit => 128, :default => '',         :null => false
      t.string   :seo_description,               :limit => 255, :default => '',         :null => false
      t.text     :seo_keywords
      t.integer  :position,                                     :default => 0,          :null => false
      t.timestamps :null => false
    end

    add_index :projects, :name
    add_index :projects, :position
    add_index :projects, :job_id
    add_index :projects, :created_at
  end
end
