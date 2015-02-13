class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags, :force => true do |t|
      t.boolean  :active,                                       :default => true,    :null => false
      t.string   :name,                          :limit => 64,  :default => "",      :null => false
      t.text     :description
      t.string   :seo_title,                     :limit => 255, :default => '',      :null => false
      t.string   :seo_h1,                        :limit => 255, :default => '',      :null => false
      t.string   :seo_description,               :limit => 255, :default => '',      :null => false
      t.text     :seo_keywords
      t.integer  :position,                                     :default => 0,       :null => false
      t.timestamps :null => false
    end

    add_index :blog_tags, :name
    add_index :blog_tags, :position
  end
end
