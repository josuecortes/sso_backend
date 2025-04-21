module Admin
  class UserPolicy < Struct.new(:user, :record)
    def index?
      user.has_active_role?('master') || user.has_active_role?('administrador')
    end

    def show?
      index?
    end

    def update?
      index?
    end

    def toggle_active?
      index?
    end

    def reset_password?
      user.has_role?('master') || user.has_role?('administrador')
    end
  end
end
