Rails.application.routes.draw do
  get 'home/index'

  get '/:locale', locale: /en|ja/, to: 'home#index'
  root to: 'home#index'

  scope '(:locale)', locale: /en|ja|vi/ do
    devise_for :users
  end
end
