module Api
  module V1
    class ProfilesController < ApplicationController
      before_action :authenticate_api_v1_auth_user!

      def show
        render json: {
          message: 'Authenticated user profile.',
          code: 200,
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
        }, status: :ok
      end

      def update
        if current_user.update(profile_params)
          render json: {
            message: 'Profile updated successfully.',
            code: 200,
            user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
          }, status: :ok
        else
          render json: {
            message: 'Profile update failed.',
            code: 422,
            errors: current_user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
      
      def update_password
        if current_user.valid_password?(params[:current_password])
          if current_user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
            render json: {
              message: 'Password updated successfully.',
              code: 200,
              user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
            }, status: :ok
          else
            render json: {
              message: 'Password update failed.',
              code: 422,
              errors: current_user.errors.full_messages
            }, status: :unprocessable_entity
          end
        else
          render json: {
            message: 'Current password is incorrect.',
            code: 401
          }, status: :unauthorized
        end
      end

      def profile_params
        params.require(:user).permit(:name, :birth_date, :phone, :whatsapp, :cpf, :matricula, :email, :password, :password_confirmation, :current_password)
      end
    end
  end
end
