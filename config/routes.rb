Rails.application.routes.draw do
  
  authenticated :user do
    root 'visits#index', as: :authenticated_root
  end
  
  devise_scope :user do
    root to: 'devise/sessions#new' # Página de login como root padrão
  end

  # Permite a confirmação de visitas apenas por funcionários (Patch)
  resources :visits do
    member do
      patch :confirm
    end
  end

  resources :visits
  resources :visitors
  resources :employees
  resources :sectors
  resources :units
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

end
