Rails.application.routes.draw do
  # root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'lists#index'
  resources :lists, only: %i[index show new create] do
    resources :bookmarks, only: %i[new create]
  end
end
