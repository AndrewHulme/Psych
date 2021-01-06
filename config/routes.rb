Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  default_url_options(protocol: (Rails.env.production? ? "https" : "http"), host: ENV["HOSTNAME"])

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/visitor-key", to: "token#visitor_key"

  root 'welcome#index'
end
