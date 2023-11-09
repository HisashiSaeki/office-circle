Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :employees, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords"
  }
  
  scope module: :public do
    resources :employees, only: [:index, :show, :edit, :update]
    resources :articles do
      resources :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :groups do
      resources :group_members, only: [:create, :destroy]
      resources :notices, only: [:new, :create, :show, :destroy]
    end
  end
  
  namespace :admin do
    resources :employees, only: [:index, :show, :edit, :update]
    resources :articles, only: [:index, :show] do
      resources :comments, only: [:destroy]
    end
    resources :departments, only: [:create, :index, :edit, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
