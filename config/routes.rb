require "sidekiq/web"

Rails.application.routes.draw do
  root "forms#index"
  resources :forms do
    resources :responses
  end

  # Montar la interfaz web de Sidekiq
  mount Sidekiq::Web => "/sidekiq"

  # Rutas adicionales
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
