class CreateRecruitmentManagers < ActiveRecord::Migration[8.0]
  def change
    create_table :recruitment_managers do |t|
      t.references :recruitment, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
