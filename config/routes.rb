Mong::Application.routes.draw do
  devise_for :users,
    :path => 'accounts',
    :controllers => {
      :omniauth_callbacks => "users/omniauth_callbacks",
    }

  resource :connections

  root :to => "home#show"
end
