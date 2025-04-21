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

      namespace :admin do
        resources :users, only: [ :index, :show, :update ] do
          member do
            patch :toggle_active, :reset_password
          end
        end
      end
    end
  end
end
