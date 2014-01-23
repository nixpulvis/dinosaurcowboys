PartyShark::Application.routes.draw do

  # Static pages.
  root 'pages#home'
  get '/recruitment', :to => 'pages#recruitment'
  get '/charter', :to => 'pages#charter'
  get '/logs', :to => 'pages#logs'

  # Devise user authentication.
  devise_for :users, :skip => :registration

  # Users, characters and applications.
  get '/roster', :to => 'characters#roster'
  resources :users do
    resources :characters, :except => :index
    resources :applications, :except => :index
  end

  # Raids and bosses.
  resources :raids do
    resources :bosses, :except => :index
  end

  # Forums and topics.
  resources :forums do
    resources :topics, :except => [:index, :new]
  end

  # Posts, my implementation requires only 1 layer of nesting.
  scope 'raids/:raid_id', :as => :raid do
    resources :posts, :only => [:create, :update, :destroy]
  end
  scope 'bosses/:boss_id', :as => :boss do
    resources :posts, :only => [:create, :update, :destroy]
  end
  scope 'topics/:topic_id', :as => :topic do
    resources :posts, :only => [:create, :update, :destroy]
  end
  scope 'applications/:application_id', :as => :application do
    resources :posts, :only => [:create, :update, :destroy]
  end

end
