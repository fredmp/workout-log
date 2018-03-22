Rails.application.routes.draw do
  # root 'home#index'
  root 'exercises#index'

  resources :exercises

  resources :routines do
    resources :routine_exercises
  end
end
