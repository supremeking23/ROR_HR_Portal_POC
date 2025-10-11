class RemoveRecruitmentManagerIdsFromRecruitments < ActiveRecord::Migration[8.0]
  def change
    remove_column :recruitments, :recruitment_manager_ids, :integer
  end
end
