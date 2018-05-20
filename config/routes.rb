Rails.application.routes.draw do

  # Change root path depending on sign-in status of user
  constraints Clearance::Constraints::SignedIn.new do
    root 'bookmarks#index'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root 'pages#index'
  end

  resources :bookmarks do
    collection do
      post :build_from_url
    end
    member do
      put :archivate
    end
  end

  get '/archive', to: 'bookmarks#archive', as: 'archived_bookmarks'
end
