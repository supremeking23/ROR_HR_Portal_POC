class AddEmployeeTypeRefToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :employee_type_ref_id, :integer
  end
end
