Rails.application.routes.draw do
  get "dashboard/index"
  devise_for :users, skip: [ :sessions, :registrations ] # Skip login & registration routes

  # Define clean  paths
  as :user do
    # login/logut
    get "login", to: "devise/sessions#new", as: :new_user_session # Login page
    post "login", to: "devise/sessions#create", as: :user_session # Login form submission

    # Registration routes
    get "register", to: "devise/registrations#new", as: :new_user_registration
    post "register", to: "devise/registrations#create", as: :user_registration

    delete "logout", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  get "dashboard", to: "dashboard#index", as: :dashboard

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "employees" => "employee#index", as: :employees
  post "create_employee" => "employee#create", as: :create_employee
  put "delete_employee" => "employee#soft_delete", as: :delete_employee

  get "recruitments" => "recruitment#index", as: :recruitments
  post "create_recruitment" => "recruitment#create", as: :create_recruitment
  put "delete_recruitment" => "recruitment#soft_delete", as: :delete_recruitment

  # JSON endpoints
  get "recruitments/load_recruitments" => "recruitment#load_recruitments"
end
