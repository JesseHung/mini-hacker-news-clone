Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :posts, only: %w[index new create show] do
    member do 
      get :upvote
      get :unvote
    end
  end

  resources :comments, only: %w[new create show] do
    member do 
      get :upvote
      get :unvote
    end
  end
end
