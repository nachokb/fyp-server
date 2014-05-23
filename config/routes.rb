Rails.application.routes.draw do
  resources :reports do
    get :candidates
  end
  resources :sightings
  get 'choices' => 'choices#index'
end
