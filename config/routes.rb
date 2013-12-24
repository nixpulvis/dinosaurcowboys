PartyShark::Application.routes.draw do

  root 'pages#home'
  get '/recruitment', :to => 'pages#recruitment'
  get '/charter', :to => 'pages#charter'
  get '/logs', :to => 'pages#logs'

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
