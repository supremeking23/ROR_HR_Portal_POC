class RefCode < ApplicationRecord
    # This sets up a one-to-many relationship:
    # One RefCode (e.g., "HR") can be linked to many Employee records
    has_many :employees, foreign_key: :employee_type_ref_id
    # Optional: validations to ensure clean data
    validates :name, :code, :code_type, presence: true
end
