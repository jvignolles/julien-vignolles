class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies, :force => true do |t|
      t.boolean  :active,                                       :default => true,       :null => false
      t.string   :name,                          :limit => 128, :default => '',         :null => false
      t.string   :location,                      :limit => 128, :default => '',         :null => false
      t.string   :website_url,                   :limit => 128, :default => '',         :null => false
      t.string   :description
      t.timestamps :null => false
    end

    add_index :companies, :name
    add_index :companies, :created_at
  end
end
