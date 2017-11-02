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
  resources :users, except:[:show]
  resources :client_appointments, except:[:show]
  resources :consulting_rooms, except:[:show]
  resources :appointment_reports, except: [:index, :show, :destroy]
  get "client_appointments/available_rooms", to: 'client_appointments#available_rooms', as: 'available_rooms'  
  #Google calendar
  get '/redirect', to: 'client_appointments#redirect', as: 'redirect'
  get '/callback', to: 'client_appointments#callback', as: 'callback'
  get '/calendars', to: 'client_appointments#calendars', as: 'calendars'
  get '/sync', to: 'client_appointments#sync', as: 'sync'
  get '/events/:calendar_id', to: 'client_appointments#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'client_appointments#new_event', as: 'new_event', calendar_id: /[^\/]+/
end
