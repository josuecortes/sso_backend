Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        devise_for :users,
                   path: "",
                   path_names: {
                     sign_in: "login",
                     sign_out: "logout",
                     registration: "signup"
                   },
                   controllers: {
                     sessions: "api/v1/auth/sessions",
                     registrations: "api/v1/auth/registrations"
                   }
      end

      resource :profile, only: [ :show, :update ] do
        patch :update_password, on: :collection
      end

      resources :roles

      resources :user_role_assignments, only: [ :index, :create, :destroy ]
      
      resources :users, only: [ :index, :show, :update ] do
        member do
          patch :toggle_active, :reset_password
        end
      end

      resources :organizational_units
      resources :organizational_unit_types
      resources :location_types

      resources :positions, only: [:index, :show, :create, :update, :destroy]
      resources :user_position_assignments, only: [ :index, :create, :destroy ]
      
    end
  end
end
