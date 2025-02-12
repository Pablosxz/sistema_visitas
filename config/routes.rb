Rails.application.routes.draw do
  
  authenticated :user do
    root 'visits#index', as: :authenticated_root
  end
  
  root 'devise/sessions#new'  # Página de login como root padrão

  resources :visits
  resources :visitors
  resources :employees
  resources :sectors
  resources :units
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

end
