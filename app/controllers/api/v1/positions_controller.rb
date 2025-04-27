class Api::V1::PositionsController < ApplicationController
  before_action :set_position, only: [ :show, :update, :destroy ]
  before_action :authorize_position

  def index
    authorize Position

    positions = Position.search(params[:search])

    if params[:sort_by].present? && Position.column_names.include?(params[:sort_by])
      order_direction = params[:order] == "desc" ? :desc : :asc
      positions = positions.order(params[:sort_by] => order_direction)
    else
      positions = positions.order(created_at: :desc)
    end

    @pagy, @positions = pagy(positions, items: (params[:per_page] || 20).to_i)

    render json: {
      code: 200,
      message: "Positions list fetched successfully.",
      positions: @positions,
      pagination: {
        current_page: @pagy.page,
        next_page: @pagy.next,
        prev_page: @pagy.prev,
        total_pages: @pagy.pages,
        total_count: @pagy.count
      }
    }, status: :ok
  end

  def show
    render json: @position
  end

  def create
    @position = Position.new(position_params)
    if @position.save
      render json: @position, status: :created
    else
      render json: @position.errors, status: :unprocessable_entity
    end
  end

  def update
    if @position.update(position_params)
      render json: @position
    else
      render json: @position.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @position.destroy
    head :no_content
  end

  private

  def set_position
    @position = Position.find(params[:id])
  end

  def authorize_position
    authorize(@position || Position)
  end

  def position_params
    params.require(:position).permit(:name, :description)
  end
end
