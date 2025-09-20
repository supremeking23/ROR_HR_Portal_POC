class CreateRefCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :ref_codes do |t|
      t.string :name
      t.string :code
      t.string :code_type

      t.timestamps
    end
  end
end
