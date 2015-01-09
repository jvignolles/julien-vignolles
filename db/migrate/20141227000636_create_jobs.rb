class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs, :force => true do |t|
      t.boolean  :active,                                       :default => true,       :null => false
      t.string   :name,                          :limit => 128, :default => '',         :null => false
      t.date     :started_on
      t.date     :ended_on
      t.text     :description
      t.integer  :company_id
      t.string   :seo_title,                     :limit => 128, :default => '',         :null => false
      t.string   :seo_h1,                        :limit => 128, :default => '',         :null => false
      t.string   :seo_description,               :limit => 255, :default => '',         :null => false
      t.text     :seo_keywords
      t.integer  :position,                                     :default => 0,          :null => false
      t.timestamps :null => false
    end

    add_index :jobs, :name
    add_index :jobs, :position
    add_index :jobs, :created_at
    add_index :jobs, [:started_on, :ended_on]
  end
end
