module Api
  module V1
    module Admin
      class LocationTypesController < ApplicationController
        before_action :set_location_type, only: [:show, :update, :destroy]
        
        def index
          authorize [:admin, LocationType]
          
          @location_types = LocationType.all
          render json: @location_types
        end

        def show
          authorize [:admin, @location_type]
          
          render json: @location_type
        end

        def create
          @location_type = LocationType.new(location_type_params)
          
          authorize [:admin, @location_type]
          if @location_type.save
            render json: @location_type, status: :created
          else
            render json: { errors: @location_type.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          authorize [:admin, @location_type]

          if @location_type.update(location_type_params)
            render json: @location_type
          else
            render json: { errors: @location_type.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          authorize [:admin, @location_type]

          if @location_type.destroy
            render json: { code: 200, message: "Location type deleted." }, status: :ok
          else
            render json: {
              code: 422,
              message: "Failed to delete Location type.",
              errors: @location_type.errors.full_messages
            }, status: :unprocessable_entity
          end

        end

        private

        def set_location_type
          @location_type = LocationType.find(params[:id])
        end

        def location_type_params
          params.require(:location_type).permit(:name, :description)
        end
      end
    end
  end
end
