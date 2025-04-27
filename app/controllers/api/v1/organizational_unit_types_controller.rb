module Api
  module V1
    class OrganizationalUnitTypesController < ApplicationController
      before_action :set_type, only: [ :show, :update, :destroy ]

      def index
        authorize OrganizationalUnitType

        @types = OrganizationalUnitType.all
        render json: @types
      end

      def show
        authorize @type

        render json: @type
      end

      def create
        @type = OrganizationalUnitType.new(organizational_unit_type_params)

        authorize @type
        if @type.save
          render json: @type, status: :created
        else
          render json: { errors: @type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @type

        if @type.update(organizational_unit_type_params)
          render json: @type
        else
          render json: { errors: @type.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @type

        if @type.destroy
          render json: { code: 200, message: "Organizational unit type deleted." }, status: :ok
        else
          render json: {
            code: 422,
            message: "Failed to delete Organizational unit type.",
            errors: @type.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def set_type
        @type = OrganizationalUnitType.find(params[:id])
      end

      def organizational_unit_type_params
        params.require(:organizational_unit_type).permit(:name, :description)
      end
    end
  end
end
