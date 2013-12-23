PartyShark::Application.routes.draw do

  root 'pages#home'

  devise_for :users, :skip => :registration

  resources :users do
    resources :characters, :only => [:new, :create, :update, :destroy]
  end
  resources :ranks

  get '/roster', :to => 'characters#roster'

  resources :raids do
    resources :bosses
  end

end
