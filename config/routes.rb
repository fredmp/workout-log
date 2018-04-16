Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'home#dashboard', as: :authenticated_root
  end

  root 'home#index'

  get 'home/index'
  get 'home/dashboard'
  get 'settings/index'
  get 'stats', to: 'stats#index'

  post 'settings/restore'
  post 'settings/weight-unit', to: 'settings#set_weight_unit'
  post 'settings/length-unit', to: 'settings#set_length_unit'

  resources :exercise_categories

  resources :exercises

  resources :body_parts

  resources :routines do
    resources :routine_exercises
  end

  resources :workouts do
    resources :workout_exercises
  end
end
