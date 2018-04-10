Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'home#dashboard', as: :authenticated_root
  end

  root 'home#index'

  get 'home/index'
  get 'home/dashboard'

  get 'settings/index'
  post 'settings/restore'

  resources :exercise_categories

  resources :exercises

  resources :routines do
    resources :routine_exercises
  end

  resources :workouts do
    resources :workout_exercises
  end
end
