Rails.application.routes.draw do
  get "users/index"
  get "users/new"
  get "users/create"
  get "users/edit"
  get "users/update"
  get "users/destroy"
  
  
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

  devise_for :users

  resources :visits
  resources :visitors

  resources :employees do
    member do
      patch :deactivate
      patch :activate
    end
  end

  resources :sectors do 
    member do
      patch :deactivate
      patch :activate
    end
  end

  resources :units do
    member do
      patch :deactivate
      patch :activate
    end
  end
  
  resources :users, except: :show  # CRUD de usuários para admin

  get "up" => "rails/health#show", as: :rails_health_check

end
