Electrodynamics::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users, :only => [:index, :show] do
    get 'personal', :on => :member
  end
  resources :organizations
  resources :comments
  resources :articles
  match '/news' => 'articles#news', as: :news
  root :to => 'articles#index'
  ActiveAdmin.routes(self)
end
