Rails.application.routes.draw do
  get 'api/index'

  get 'home/index'

  get '/:locale', locale: /en|ja|vi/, to: 'home#index'
  root to: 'home#index'

  scope '(:locale)', locale: /en|ja|vi/ do
    devise_for :users, skip: [:registrations, :unlocks], controllers: {
      # registrations: 'users/registrations',
      # unlocks: 'users/unlocks',
      sessions: 'users/sessions',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords'
    }

    as :user do
      get    'sign_up', to: 'users/registrations#new',
        as: :new_user_registration
      get    'users/cancel',  to: 'users/registrations#cancel',
        as: :cancel_user_registration
      post   'users',         to: 'users/registrations#create',
        as: :user_registration
      delete 'users',         to: 'users/registrations#destroy'

      get    'settings/password', to: 'users/settings/passwords#edit',
        as: :edit_user_settings_password
      put    'settings/password', to: 'users/settings/passwords#update',
        as: :user_settings_password
      patch  'settings/password', to: 'users/settings/passwords#update'

      get    'settings/account', to: 'users/settings/accounts#edit',
        as: :edit_user_settings_account
      put    'settings/account', to: 'users/settings/accounts#update',
        as: :user_settings_account
      patch  'settings/account', to: 'users/settings/accounts#update'
    end

    namespace :users do
      post '/:user_id', to: 'followings#create', as: :followings
      delete '/:user_id', to: 'followings#destroy'
    end

    scope module: :profiles do
      get '/:user_id', action: :show, as: :profile
      get '/:user_id/followers', action: :followers, as: :profile_followers
      get '/:user_id/following', action: :following, as: :profile_following
      get '/:user_id/likes', action: :likes, as: :profile_likes
    end

    scope module: :feeds do
      resources :tweets, only: [:show, :update, :create, :destroy] do
        member do
          get    'like', to: 'likes#index',   as: :like
          post   'like', to: 'likes#create'
          delete 'like', to: 'likes#destroy'

          get    'retweet', to: 'retweets#index',   as: :retweet
          post   'retweet', to: 'retweets#create'
          delete 'retweet', to: 'retweets#destroy'
        end
      end
    end

    scope module: :replies do
      resources :replies, only: [] do
        member do
          get    'like', to: 'likes#index',   as: :like
          post   'like', to: 'likes#create'
          delete 'like', to: 'likes#destroy'

          get    'retweet', to: 'retweets#index',   as: :retweet
          post   'retweet', to: 'retweets#create'
          delete 'retweet', to: 'retweets#destroy'
        end
      end
    end

    resources :tweets, only: [] do
      resources :replies, shallow: true, controller: "tweets/replies" do
        resources :replies, only: [:create, :new, :index], controller: "tweets/replies"
      end
    end
  end
end
