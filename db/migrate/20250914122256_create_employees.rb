class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :user
      t.string :references
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.text :address1
      t.text :address2
      t.string :city
      t.string :mobile_number
      t.string :employee_type
      t.date :birthdate

      t.timestamps
    end
  end
end
