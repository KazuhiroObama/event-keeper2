Rails.application.routes.draw do
  root 'events#index'

  devise_for :users
  #devise_forでは'user#show'ページが追加されないため、以下に設定
  devise_scope :user do
   get :show, to: 'users#show', as: 'users_show'
  end

  resources :events do
    get :past, on: :collection
    resources :comments, only: [:create, :destroy]
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :managements, only: [:create, :destroy]
end
