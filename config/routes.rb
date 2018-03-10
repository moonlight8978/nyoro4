Rails.application.routes.draw do
  get 'home/index'

  get '/:locale', locale: /en|ja/, to: 'home#index'
  root to: 'home#index'

  scope '(:locale)', locale: /en|ja|vi/ do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      unlocks: 'users/unlocks',
      passwords: 'users/passwords'
    }
  end
end
