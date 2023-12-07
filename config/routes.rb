Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions",
  }
  devise_for :employees, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
  }
  devise_scope :employee do
    post "employees/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"
    get "employees_search" => "searches#employees_search"
    get "articles_search" => "searches#articles_search"
    get "groups_search" => "searches#groups_search"
    get "department_search" => "searches#department_search"
    get "tag_search" => "searches#tag_search"

    resources :activities, only: [:index] do
      collection do
        delete "destroy_all" => "activities#destroy_all"
      end
    end
    resources :employees, only: [:index, :show, :edit, :update]
    resources :articles do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :groups do
      resource :group_members, only: [:create, :destroy]
      resources :notices, only: [:new, :create, :show, :destroy]
    end
  end

  namespace :admin do
    get "employees_search" => "searches#employees_search"
    get "articles_search" => "searches#articles_search"
    get "department_search" => "searches#department_search"
    get "tag_search" => "searches#tag_search"

    resources :employees, only: [:index, :show, :edit, :update]
    resources :articles, only: [:index, :show] do
      resources :comments, only: [:destroy]
    end
    resources :departments, only: [:create, :index, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
