Rails.application.routes.draw do
  post 'sessions/sign_in', to: 'sessions#sign_in', constraints: {format: 'json'}
end
