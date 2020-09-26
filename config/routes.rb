Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts, only: [:index, :show]
  resources :artists, only: [:index, :show, :update] do
    member do
      post :follow
      post :unfollow
    end

  end
  resources :contents, only: [:index, :show]
  get '/posts' => "posts#index", :as => :user_root
end
