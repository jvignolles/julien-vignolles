class CreateProjectsSkills < ActiveRecord::Migration
  def change
    create_table :projects_skills, :id => false, :force => true do |t|
      t.integer  :project_id, :null => false
      t.integer  :skill_id,   :null => false
    end

    add_index :projects_skills, [:project_id, :skill_id]
  end
end
