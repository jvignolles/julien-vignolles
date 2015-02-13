class CreateBlogTopics < ActiveRecord::Migration
  def change
    create_table :blog_topics, :force => true do |t|
      t.boolean  :active,                                       :default => true,    :null => false
      t.integer  :admin_id
      t.string   :name,                          :limit => 128, :default => "",      :null => false
      t.text     :introduction
      t.text     :description
      t.string   :seo_title,                     :limit => 255, :default => '',      :null => false
      t.string   :seo_h1,                        :limit => 255, :default => '',      :null => false
      t.string   :seo_description,               :limit => 255, :default => '',      :null => false
      t.text     :seo_keywords
      t.datetime :published_at
      t.timestamps :null => false
    end

    add_index :blog_topics, :admin_id
    add_index :blog_topics, :name
    add_index :blog_topics, :published_at
    add_index :blog_topics, :created_at
  end
end
