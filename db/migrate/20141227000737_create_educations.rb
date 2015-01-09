class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations, :force => true do |t|
      t.boolean  :active,                                       :default => true,       :null => false
      t.string   :name,                          :limit => 128, :default => '',         :null => false
      t.string   :option,                        :limit => 128, :default => '',         :null => false
      t.string   :establishment,                 :limit => 128, :default => '',         :null => false
      t.string   :location,                      :limit => 128, :default => '',         :null => false
      t.string   :website_url,                   :limit => 128, :default => '',         :null => false
      t.date     :started_on
      t.date     :ended_on
      t.text     :description
      t.integer  :position,                                     :default => 0,          :null => false
      t.timestamps :null => false
    end

    add_index :educations, :name
    add_index :educations, :position
    add_index :educations, :created_at
    add_index :educations, [:started_on, :ended_on]
  end
end
