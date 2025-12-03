Rails.application.routes.draw do
  resources :salas do
    member do
      post :add_usuario
      patch :update_vinculo
      delete :remove_usuario
    end

    resources :mensagens
  end

  devise_for :usuarios

  root "salas#index"
end
