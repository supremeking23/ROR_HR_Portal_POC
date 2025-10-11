class CreateRecruitments < ActiveRecord::Migration[8.0]
  def change
    create_table :recruitments do |t|
      t.text :description
      t.integer :job_position_id
      t.integer :vacancies
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
