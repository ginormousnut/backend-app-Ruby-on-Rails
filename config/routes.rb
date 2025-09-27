Rails.application.routes.draw do
  resources :patients do
    resources :bmrs, only: [ :index, :create ]
    resource :bmi, only: [ :show ]   # /patients/:patient_id/bmi
  end
  resources :doctors
end
