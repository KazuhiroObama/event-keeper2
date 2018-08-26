Rails.application.routes.draw do
  devise_for :users
  resources :events do
    get :post, on: :collection
    resources :comments, only: [:create, :destroy]
  end
  root to: "events#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :users, only: [:show]
  resources :managements, only: [:create, :destroy]
end
