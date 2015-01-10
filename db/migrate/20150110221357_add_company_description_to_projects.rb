class AddCompanyDescriptionToProjects < ActiveRecord::Migration
  def change
    add_column    :projects, :company_description, :string, :null => false, :default => '', :limit => 255
  end
end
