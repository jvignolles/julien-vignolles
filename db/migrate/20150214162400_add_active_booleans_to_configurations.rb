class AddActiveBooleansToConfigurations < ActiveRecord::Migration
  def change
    add_column    :configurations, :entertainments_active,       :boolean, :null => false, :default => false
    add_column    :configurations, :highlighted_projects_active, :boolean, :null => false, :default => false
  end
end
