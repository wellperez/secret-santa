require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'pages#home'
  resources :campaigns, except: [:new] do
    post 'raffle', on: :member
    # post 'raffle', on: :collection
  end
  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: %i[create destroy update]

  devise_for :users, controllers: { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'
end
