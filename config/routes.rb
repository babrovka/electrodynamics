Electrodynamics::Application.routes.draw do
  devise_for :users
  resources :articles
  resources :comments
  root :to => 'articles#index'
  ActiveAdmin.routes(self)
end
