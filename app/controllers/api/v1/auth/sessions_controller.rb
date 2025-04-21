module Api
  module V1
    module Auth
      class SessionsController < Devise::SessionsController
        respond_to :json

        # Sobrescreve a action padrão de login
        def create
          user = User.find_by(email: sign_in_params[:email])

          if user&.valid_password?(sign_in_params[:password])
            sign_in(user)
            render json: {
              message: 'Logged in successfully.',
              code: 200,
              user: UserSerializer.new(user).serializable_hash[:data][:attributes]
            }, status: :ok
          else
            render json: {
              message: 'Invalid email or password.',
              code: 401
            }, status: :unauthorized
          end
        end

        def respond_to_on_destroy
          jwt_payload = JWT.decode(
            request.headers['Authorization'].split(' ').last,
            Rails.application.credentials.devise[:jwt_secret_key]
          ).first

          current_user = User.find_by(id: jwt_payload['sub'])

          if current_user
            render json: {
              message: 'Logged out successfully.',
              code: 200
            }, status: :ok
          else
            render json: {
              message: 'Logout failed.',
              code: 401
            }, status: :unauthorized
          end
        end

        private

        def sign_in_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
