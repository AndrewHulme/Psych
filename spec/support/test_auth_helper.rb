require "devise/jwt/test_helpers"

module TestAuthHelper
  def delete_auth_cookies
    cookies.delete "_psych_session"
    cookies.delete "visitor_key"
  end

  def current_user
    @current_user ||= User.find_by(visitor_key: cookies[:visitor_key])
  end

  def create_user_session
    get "/"
    User.last
  end

  def set_current_user(user)
    cookies[:visitor_key] = user.visitor_key
  end

  def user_auth_headers(user)
    headers = { "Accept" => "application/json", "Content-Type" => "application/json" }
    # This will add a valid token for `user` in the `Authorization` header
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end
