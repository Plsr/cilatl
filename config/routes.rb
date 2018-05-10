Rails.application.routes.draw do
  root 'pages#index'
  resources :bookmarks do
    member do
      put :archivate
    end
  end

  get '/archive', to: 'bookmarks#archive', as: 'archived_bookmarks'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
