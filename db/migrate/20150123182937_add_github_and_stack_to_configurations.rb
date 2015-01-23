class AddGithubAndStackToConfigurations < ActiveRecord::Migration
  def change
    add_column    :configurations, :github_url,        :string, :null => false, :default => '', :limit => 128
    add_column    :configurations, :stackoverflow_url, :string, :null => false, :default => '', :limit => 128
  end
end
