class CreateBlogTagsBlogTopics < ActiveRecord::Migration
  def change
    create_table :blog_tags_blog_topics, :force => true, :id => false do |t|
      t.integer  :blog_tag_id
      t.integer  :blog_topic_id
    end

    add_index :blog_tags_blog_topics, [:blog_tag_id, :blog_topic_id]
  end
end
