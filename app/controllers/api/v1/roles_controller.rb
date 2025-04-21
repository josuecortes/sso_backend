module Api
  module V1
    class RolesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_role, only: %i[show update destroy]
      after_action :verify_authorized

      def index
        @roles = Role.all
        authorize Role
        render json: { code: 200, message: 'Roles list fetched successfully.', roles: @roles }, status: :ok
      end

      def show
        authorize @role
        render json: { code: 200, message: 'Role fetched.', role: @role }, status: :ok
      end

      def create
        @role = Role.new(role_params)
        authorize @role
        if @role.save
          render json: { code: 201, message: 'Role created.', role: @role }, status: :created
        else
          render json: { code: 422, errors: @role.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @role
        if @role.update(role_params)
          render json: { code: 200, message: 'Role updated.', role: @role }, status: :ok
        else
          render json: { code: 422, errors: @role.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @role
        if @role.destroy
          render json: { code: 200, message: 'Role deleted.' }, status: :ok
        else
          render json: { 
            code: 422, 
            message: 'Failed to delete role.', 
            errors: @role.errors.full_messages 
          }, status: :unprocessable_entity
        end
      end

      private

      def set_role
        @role = Role.find(params[:id])
      end

      def role_params
        params.require(:role).permit(:name, :description)
      end
    end
  end
end
