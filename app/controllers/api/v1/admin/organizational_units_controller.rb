module Api
  module V1
    module Admin
      class OrganizationalUnitsController < ApplicationController
        before_action :set_unit, only: [ :show, :update, :destroy ]

        def index
          authorize [ :admin, OrganizationalUnit ]

          @units = OrganizationalUnit.all
          render json: @units
        end

        def show
          authorize [ :admin, @unit ]

          render json: @unit
        end

        def create
          @unit = OrganizationalUnit.new(organizational_unit_params)

          authorize [ :admin, @unit ]
          if @unit.save
            render json: @unit, status: :created
          else
            render json: { errors: @unit.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def update
          authorize [ :admin, @unit ]

          if @unit.update(organizational_unit_params)
            render json: @unit
          else
            render json: { errors: @unit.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          authorize [ :admin, @unit ]

          if @unit.destroy
            render json: { code: 200, message: "Organizational unit deleted." }, status: :ok
          else
            render json: {
              code: 422,
              message: "Failed to delete Organizational unit.",
              errors: @unit.errors.full_messages
            }, status: :unprocessable_entity
          end
        end

        private

        def set_unit
          @unit = OrganizationalUnit.find(params[:id])
        end

        def organizational_unit_params
          params.require(:organizational_unit).permit(:name, :code, :sigla, :active, :parent_id, :organizational_unit_type_id, :location_type_id)
        end
      end
    end
  end
end
