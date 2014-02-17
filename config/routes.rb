PartyShark::Application.routes.draw do

  # Static pages.
  root 'pages#home'
  get '/charter', to: 'pages#charter'
  get '/logs', to: 'pages#logs'

  # Devise user authentication.
  devise_for :users, skip: :registration

  # Features.
  resources :features, except: [:index, :show]

  # Users, characters and applications.
  get '/roster', to: 'characters#roster'
  resources :users do
    resources :characters, except: :index
    resource :application do
      member { match 'decide', via: [:put, :patch] }
    end
  end
  get '/applications', to: 'applications#index'

  # Recruitment.
  resource :recruitment, only: [:show, :edit, :update]

  # Mumble.
  get '/mumble', to: 'mumble#index'

  # Raids and bosses.
  resources :raids do
    resources :bosses, except: :index
  end

  # Forums and topics.
  resources :forums do
    resources :topics, except: [:index, :new]
  end

  # Posts, my implementation requires only 1 layer of nesting.
  scope 'raids/:raid_id', as: :raid do
    resources :posts, only: [:create, :update, :destroy]
  end
  scope 'bosses/:boss_id', as: :boss do
    resources :posts, only: [:create, :update, :destroy]
  end
  scope 'topics/:topic_id', as: :topic do
    resources :posts, only: [:create, :update, :destroy]
  end
  scope 'applications/:application_id', as: :application do
    resources :posts, only: [:create, :update, :destroy]
  end

  # Errors.
  match '404', to: 'errors#not_found', via: :all
  match '422', to: 'errors#unprocessable_entity', via: :all
  match '500', to: 'errors#internal_server_error', via: :all

end
