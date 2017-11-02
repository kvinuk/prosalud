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
end
