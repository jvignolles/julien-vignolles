class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts, :force => true do |t|
      t.integer  :parent_id
      t.string   :name,       :limit => 128, :null => false, :default => ""
      t.string   :email,      :limit => 80,  :null => false, :default => ""
      t.string   :phone,      :limit => 20,  :null => false, :default => ""
      t.string   :subject,    :limit => 50,  :null => false, :default => ""
      t.text     :description
      t.integer  :admin_id
      t.datetime :answered_at
      t.integer  :answerer_id
      t.integer  :latest_answer_id
      t.timestamps :null => false
    end

    add_index :contacts, [:name, :email]
    add_index :contacts, :created_at
  end
end
