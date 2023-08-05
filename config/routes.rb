Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  resources :users do
    resources :relationships, only: [:create]
  end

  delete '/users/:user_id/relationships', to: 'relationships#destroy', as: :destroy_relationship

  resources :posts do
    resources :comments, only: [:create, :destroy, :show]
    
    resource :likes, only: [:create, :destroy, :show], controller: 'likes' do
      get 'users', on: :member, to: 'likes#show_users'
      get 'count', on: :member, to: 'likes#count'
    end

    collection do
      get :my_posts
    end
  end

  root to: "posts#index"
end
