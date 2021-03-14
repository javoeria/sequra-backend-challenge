Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  apipie
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get 'disbursements', to: 'disbursements#index'
    end
  end
end
