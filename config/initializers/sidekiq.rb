require "sidekiq/web"

namespace = "psych"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: namespace }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV["SIDEKIQ_LOGIN"], ENV["SIDEKIQ_PASSWORD"]]
end
