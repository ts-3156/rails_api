Rails.application.routes.draw do
  post 'registrations/sign_up', to: 'registrations#sign_up', constraints: {format: 'json'}
  post 'sessions/sign_in', to: 'sessions#sign_in', constraints: {format: 'json'}
end
