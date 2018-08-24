Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :comments
  end
  root to: "events#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :users, only: [:show]
  resources :participants, only: [:create, :destroy]
end
