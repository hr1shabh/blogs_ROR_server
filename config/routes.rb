Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  resources :users do
    resources :relationships, only: [:create]
  end

  delete '/users/:user_id/relationships', to: 'relationships#destroy', as: :destroy_relationship

  get 'checkout/success', to: 'checkouts#success'
  get '/checkout/:subscription_plan_id', to: 'checkouts#show', as: :checkout

  get 'billing', to: 'billing#show'
  resources :posts do
    resources :comments, only: [:create, :destroy, :show]
    
    resource :likes, only: [:create, :destroy, :show], controller: 'likes' do
      get 'users', on: :member, to: 'likes#show_users'
      get 'count', on: :member, to: 'likes#count'
    end
    post :bookmark, on: :member
    get :bookmarked_posts, on: :collection
    collection do
      get :my_posts
      get :top_posts
      get :more_posts_by_user
      get :posts_by_topic
      get :recommended_posts
      get :most_commented_posts
      get :posts_by_date
    end
  end
  resources :lists, except: [:new, :edit] do
    resources :list_items, only: [:create, :destroy]
  end
  

  post '/posts/publish', to: 'posts#create', status: 'published', as: :publish_posts # Route to publish a post
  post '/posts/draft', to: 'posts#create', status: 'draft', as: :draft_posts # Route to create a draft

  root to: "posts#index"
end
