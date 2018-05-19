Rails.application.routes.draw do

  # Change root path depending on sign-in status of user
  constraints Clearance::Constraints::SignedIn.new do
    root 'bookmarks#index'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root 'pages#index'
  end

  resources :bookmarks do
    member do
      put :archivate
    end
  end

  get '/archive', to: 'bookmarks#archive', as: 'archived_bookmarks'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
