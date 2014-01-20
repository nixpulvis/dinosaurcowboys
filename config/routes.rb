PartyShark::Application.routes.draw do

  root 'pages#home'
  get '/recruitment', :to => 'pages#recruitment'
  get '/charter', :to => 'pages#charter'
  get '/logs', :to => 'pages#logs'

  devise_for :users, :skip => :registration

  get '/roster', :to => 'characters#roster'
  resources :users do
    resources :characters, :except => :index
  end

  resources :raids do
    resources :bosses
  end

  scope 'raids/:raid_id', :as => :raid do
    resources :posts, :only => [:create, :update, :destroy]
  end
  scope 'bosses/:boss_id', :as => :boss do
    resources :posts, :only => [:create, :update, :destroy]
  end

  resources :forums do
    resources :topics, :except => [:index, :new]
  end

  scope 'topics/:topic_id', :as => :topic do
    resources :posts, :only => [:create, :update, :destroy]
  end

end
