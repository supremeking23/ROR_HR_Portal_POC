class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_current_user
  before_action :set_current_employee
  helper_method :current_employee

  # pagination module
  include Pagy::Backend

  def set_current_user
    Current.user = current_user  # Devise's current_user
  end

  def set_current_employee
    @current_employee = Employee.find_by(id: Current.user)
  end

  def current_employee
    @current_employee
  end



  # Customize where users land after loggin in
  def after_sign_in_path_for(user)
    dashboard_path # Replace with your actual dashboard route
  end

  # Redirect users after successful registration
  def after_sign_up_path_for(user)
    dashboard_path # Replace with your actual landing page
  end

  def after_sign_out_path_for(user_or_scope)
    new_user_session_path # or login_path, or any public landing page
  end

  # def get_user_information_of_currently_logged_in_user

  #   @current_user = Employee.find_by(id: Current.user&.employee_id)
  # end
end
