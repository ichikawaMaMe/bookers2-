Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => "homes#about"
  resources :homes, only: [:top,:about]
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:new, :index, :show, :create, :destroy, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
