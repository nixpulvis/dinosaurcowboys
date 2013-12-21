PartyShark::Application.routes.draw do

  root 'pages#home'

  devise_for :users, :skip => :registration

  resources :users do
    resources :characters
  end
  resources :ranks

end
