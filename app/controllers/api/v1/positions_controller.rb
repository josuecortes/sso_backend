class Api::V1::PositionsController < ApplicationController
  before_action :set_position, only: [:show, :update, :destroy]
  before_action :authorize_position

  def index
    @positions = Position.all
    render json: @positions
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
