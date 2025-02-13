class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(user)
    if user.admin?
      users_path # Página de usuários
    elsif user.attendant?
      visitors_path # Página de visitantes
    elsif user.employee?
      visits_path # Página de visitantes
    else
      root_path # Página padrão
    end
  end

end
