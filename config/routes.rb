Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels
  resources :schedules, except:[:show]
  resources :clients
  resources :services
  resources :client_appointments

  #Google calendar
  get '/redirect', to: 'client_appointments#redirect', as: 'redirect'
  get '/callback', to: 'client_appointments#callback', as: 'callback'
  get '/calendars', to: 'client_appointments#calendars', as: 'calendars'
  get '/index_calendar', to: 'client_appointments#index_calendar', as: 'index_calendar'
  get '/events/:calendar_id', to: 'client_appointments#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'client_appointments#new_event', as: 'new_event', calendar_id: /[^\/]+/
end
