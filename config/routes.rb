Rails.application.routes.draw do
  # root 'home#index'
  root 'exercises#index'

  resources :exercises
end
