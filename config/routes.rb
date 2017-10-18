Rails.application.routes.draw do
  get 'documentation/index'

  namespace :admin do
    resources :items
    resources :item_sessions
    resources :skus

    root to: "items#index"
  end

  scope :items do
    scope '/:code' do
      get '/' => 'items#show'
      scope '/sessions' do
        get '/' => 'item_sessions#index'
        post '/' => 'item_sessions#create'

        scope '/:id' do
          get '/' => 'item_sessions#show', as: :item_session
          put '/' => 'item_sessions#update'
        end
      end
    end
  end

  resources :skus, only: :show

  get "/search" => "item_sessions#search"

  scope :docs do
    root to: "documentation#index"
  end

  root to: "item_sessions#client"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
