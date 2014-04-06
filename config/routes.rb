FitService::Application.routes.draw do
  mount Fit::ApiV1 => '/'
end
