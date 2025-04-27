class Api::V1::UserPositionAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assignment, only: %i[destroy]

  def index
    @assignments = UserPositionAssignment.includes(:position, :user)
    authorize UserPositionAssignment
    render json: @assignments
  end

  def create
    @assignment = UserPositionAssignment.new(assignment_params)

    authorize @assignment
    if @assignment.save
      render json: @assignment, status: :created
    else
      render json: @assignment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @assignment
    @assignment.update(active: false, removed_at: Time.current)
    render json: { code: 200, message: "Position removed from user.", assignment: @assignment }, status: :ok
  end

  private

  def set_assignment
    @assignment = UserPositionAssignment.find(params[:id])
  end

  def assignment_params
    params.require(:user_position_assignment).permit(:user_id, :position_id, :organizational_unit_id, :active)
  end
end
