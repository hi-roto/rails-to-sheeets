Rails.application.routes.draw do
  resources :sheets, only: [:create]
  delete '/sheets', to: 'sheets#destroy', as: 'sheets_destroy'
end
