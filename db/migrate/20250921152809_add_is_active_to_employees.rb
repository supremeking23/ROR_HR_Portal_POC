class AddIsActiveToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :is_active, :integer, default: 1
  end
end
