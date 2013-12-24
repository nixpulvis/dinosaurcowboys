PartyShark::Application.routes.draw do

  root 'pages#home'
  get '/recruitment', :to => 'pages#recruitment'
  get '/charter', :to => 'pages#charter'
  get '/logs', :to => 'pages#logs'

  devise_for :users, :skip => :registration

  get '/roster', :to => 'characters#roster'
  resources :users do
    resources :characters, :only => [:new, :create, :update, :destroy]
  end

  resources :raids do
    resources :bosses
  end

end
