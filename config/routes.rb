Rails.application.routes.draw do


  namespace :public do
    post "orders/confirm" => "orders#confirm" , as: "order_confirm"
    get "orders/thanks" => "orders#thanks" , as: "order_thanks"
      resources :orders, only:[:new,:show,:create,:index] do
        collection do

      end
    end

  end
  namespace :public do
    delete "cart_items/destroy_all" => "cart_items#destroy_all" , as: "cart_items_destroy_all"
   resources :cart_items, only:[:index,:create,:update,:destroy]
  end
  namespace :public do
   resources :items, only:[:index,:show]
  end
  namespace :public do
      resources :addresses, only:[:index,:edit,:create,:update,:destroy]
  end
namespace :public do
    get "customers/confirm" => "customers#confirm" , as: "customer_confirm"
    patch "customers/lose" => "customers#lose" , as: "customer_lose"
      resources :customers, only:[:show,:edit,:update]

end

#   namespace :public do
    # get '/about'
#   end


    get "/admin" => "admin/homes#top", as:"top"

    devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

 devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  namespace :admin do
   resources :items, only:[:new, :create, :index, :show, :edit, :update]
  end

  namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
  end

  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :orders, only:[:show,:update]
  end

  get "/about" => "public/homes#about", as:"about"
  root to:'public/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
