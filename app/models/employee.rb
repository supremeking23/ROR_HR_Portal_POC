class Employee < ApplicationRecord
  # Each employee record is linked to a user (e.g., for login or ownership)
  belongs_to :user
  # This sets up a foreign key relationship to the RefCode table
  # Specifically for employee type (e.g., HR, IT, Finance)
  belongs_to :employee_type_ref, class_name: "RefCode", optional: true

  # Validations to ensure key fields are present before saving
  validates :firstname, :lastname, :employee_type_ref_id, presence: true

  # Returns the human-readable label for the employee type
  # Example: "Human Resources" instead of just "hr"
  def employee_type_label
    employee_type_ref&.name
  end
end
