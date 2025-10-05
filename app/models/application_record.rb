class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  # def get_user_information_of_currently_logged_in_user
  #   User.find_by(id: Current.user&.id)
  #   Employee.find_by(id: Current.user&.employee_id)
  # end
end
