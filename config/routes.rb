Rails.application.routes.draw do
  get 'articles/show'
  get 'videos/show'
  get 'coachs/show'
  get 'answers/create'
  get 'answer/create'
  get 'questions/show'
  get 'steps/index'
  devise_for :users
  root to: 'pages#home'
  resources :questions, only: :show
  resources :answers, only: :create
  resources :steps, only: :index
  resources :coachs, only: :show
  resources :videos, only: :show
  resources :articles, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
