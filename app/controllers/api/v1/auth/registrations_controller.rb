module Api
  module V1
    module Auth
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          if resource.persisted?
            render json: {
              message: "Signed up successfully.",
              code: 201,
              user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
            }, status: :created
          else
            render json: { message: "Sign up failed.", errors: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # Permitir parâmetros fortes para sign_up
        def sign_up_params
          # params.require(:user).permit(:email, :password, :password_confirmation, :nome, :cpf, :unit_id)
          params.require(:user).permit(:name, :birth_date, :phone, :whatsapp, :cpf, :matricula, :email, :password, :password_confirmation, :current_password)
        end
      end
    end
  end
end
