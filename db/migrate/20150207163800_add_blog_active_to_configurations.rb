class AddBlogActiveToConfigurations < ActiveRecord::Migration
  def change
    add_column    :configurations, :blog_active, :boolean, :null => false, :default => false
  end
end
