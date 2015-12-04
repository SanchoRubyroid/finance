Rails.application.routes.draw do
  root to: 'finance#index'
  devise_for :users

  devise_scope :user do
    get :sign_out, to: 'devise/sessions#destroy'
  end
end
