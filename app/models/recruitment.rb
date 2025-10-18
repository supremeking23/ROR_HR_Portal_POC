class Recruitment < ApplicationRecord
    # Establishes a one-to-many relationship with recruitment_managers
    # Each recruitment can have multiple manager assignments
    has_many :recruitment_managers
    # Through the recruitment_managers join table, this sets up access to the actual manager records
    # Assumes recruitment_managers has an employee_id column pointing to the employees table
    # :managers will return Employee records associated with this recruitment
    # :managers is a custom alias for better readability
    # It’s creating a custom alias (:managers) for the employees associated through recruitment_managers.
    # The source: :employee tells Rails: “Hey, the actual data lives in the employees table, not in a separate managers table.
    has_many :managers, through: :recruitment_managers, source: :employee
    # Optional association to a reference code (e.g., job title or classification)
    # Maps job_position_id to the RefCode model, allowing semantic lookup
    belongs_to :job_position_ref, class_name: "RefCode", foreign_key: "job_position_id", optional: true
end
