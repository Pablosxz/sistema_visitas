Rails.application.routes.draw do
  get "users/index"
  get "users/new"
  get "users/create"
  get "users/edit"
  get "users/update"
  get "users/destroy"

  # Rota para buscar funcionários por setor
  get "/sectors/:sector_id/employees", to: "sectors#employees"


  authenticated :user do
    root "visits#index", as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new" # Página de login como root padrão
  end

  # Página de busca de visitantes
  get "/visitors/search", to: "visitors#search"

  # Permite a confirmação de visitas apenas por funcionários (Patch)
  resources :visits do
    member do
      patch :confirm
    end
  end

  devise_for :users

  resources :visits
  resources :visitors do
    member do
      patch :deactivate
      patch :activate
    end
  end

  resources :employees do
    member do
      patch :deactivate
      patch :activate
      get :reactivate
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
      get :sectors
      patch :deactivate
      patch :activate
    end
  end

  resources :users, except: :show  # CRUD de usuários para admin

  get "up" => "rails/health#show", as: :rails_health_check
end
