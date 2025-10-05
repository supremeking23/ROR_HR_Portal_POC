class RemoveEmployeeTypeFromEmployees < ActiveRecord::Migration[8.0]
  def change
    remove_column :employees, :employee_type, :string
  end
end
