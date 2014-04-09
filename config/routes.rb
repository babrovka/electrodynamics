Electrodynamics::Application.routes.draw do
  
  devise_for :users
  resources :organizations
  resources :articles
  match '/news' => 'articles#news', as: :news
  resources :comments
  root :to => 'articles#index'
  ActiveAdmin.routes(self)
end
