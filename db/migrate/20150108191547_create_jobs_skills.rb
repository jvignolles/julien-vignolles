class CreateJobsSkills < ActiveRecord::Migration
  def change
    create_table :jobs_skills, :id => false, :force => true do |t|
      t.integer  :job_id,   :null => false
      t.integer  :skill_id, :null => false
    end

    add_index :jobs_skills, [:job_id, :skill_id]
  end
end
