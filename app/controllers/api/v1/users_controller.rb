module Api
  module V1
    class UsersController < ApplicationController
      # before_action :set_user, only: [:show]
      before_action :set_user, only: [ :show, :update, :toggle_active, :reset_password ]

      def index
        authorize User
        users = User.all

        render json: {
          message: "Users retrieved successfully.",
          code: 200,
          users: users.map { |user| UserSerializer.new(user).serializable_hash[:data][:attributes] }
        }, status: :ok
      end

      def show
        authorize @user

        render json: {
          message: "User retrieved successfully.",
          code: 200,
          user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
        }, status: :ok
      end

      def update
        authorize @user
        if @user.update(user_params)
          render json: {
            message: "User updated successfully.",
            code: 200,
            user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
          }, status: :ok
        else
          render json: {
            message: "User update failed.",
            code: 422,
            errors: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def toggle_active
        authorize @user
        @user.active = !@user.active
        if @user.save
          render json: {
            message: "User has been #{@user.active ? 'activated' : 'deactivated'}.",
            code: 200,
            user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
          }, status: :ok
        else
          render json: {
            message: "Failed to update user status.",
            code: 422,
            errors: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def reset_password
        authorize @user
        if @user.update(password: "Seed@123", password_confirmation: "Seed@123")
          render json: {
            message: "Password reset successfully.",
            code: 200,
            user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
          }, status: :ok
        else
          render json: {
            message: "Failed to reset password.",
            code: 422,
            errors: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :cpf, :email)
      end
    end
  end
end
