module Api
  module V1
    class UserRoleAssignmentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_assignment, only: %i[destroy]
      after_action :verify_authorized

      def index
        @assignments = UserRoleAssignment.includes(:role, :user)
        authorize UserRoleAssignment
        render json: { code: 200, message: "User role assignments fetched.", assignments: @assignments.as_json(include: [ :role, :user ]) }, status: :ok
      end

      def create
        @assignment = UserRoleAssignment.new(assignment_params)
        @assignment.assigned_by = current_user
        @assignment.assigned_at = Time.current

        authorize @assignment

        if @assignment.save
          render json: { code: 201, message: "Role assigned to user.", assignment: @assignment }, status: :created
        else
          render json: { code: 422, errors: @assignment.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @assignment
        @assignment.update(active: false, removed_at: Time.current)
        render json: { code: 200, message: "Role removed from user.", assignment: @assignment }, status: :ok
      end

      private

      def set_assignment
        @assignment = UserRoleAssignment.find(params[:id])
      end

      def assignment_params
        params.require(:user_role_assignment).permit(:user_id, :role_id, :active)
      end
    end
  end
end
