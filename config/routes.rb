Rails.application.routes.draw do
  root to: 'finance#index'

  devise_for :users

  devise_scope :user do
    get :sign_out, to: 'devise/sessions#destroy'
  end

  get '/:month', to: 'finance#index', as: 'finances'
  post '/', to: 'finance#index', as: 'update_finances'

  namespace :admin do
    get '/' => 'home#index', as: 'home'

    resources :money_transactions, only: [:index] do
      post 'upload', on: :collection
    end
  end
end
