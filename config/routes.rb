PartyShark::Application.routes.draw do

  root 'pages#home'

  devise_for :users

  resources :user, only: [:index, :show] do
    resources :character
  end
  resources :ranks

end
