class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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
end
