FitService::Application.routes.draw do
  resources :workouts, only:  :create
end
