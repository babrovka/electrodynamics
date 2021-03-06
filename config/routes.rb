Electrodynamics::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users, :only => [:index, :show] do
    get 'personal', :on => :member
  end
  resources :themes, :only => [:show]
  resources :organizations
  resources :comments
  resources :blogs
  resources :documents
  resources :invites
  resources :articles do 
    collection do
      get 'by_category'
      get 'by_organizations'
    end
  end
  match '/news' => 'articles#news', as: :news
  match '/search' => 'static_pages#search', as: :search
  root :to => 'static_pages#index'
  ActiveAdmin.routes(self)
end
