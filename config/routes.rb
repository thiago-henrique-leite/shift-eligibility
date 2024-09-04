Rails.application.routes.draw do
  root to: redirect('/docs')

  mount Rswag::Ui::Engine => '/docs'
  mount Rswag::Api::Engine => '/docs'

  namespace :api do
    namespace :v1 do
      resources :shifts, only: :index
    end
  end
end
