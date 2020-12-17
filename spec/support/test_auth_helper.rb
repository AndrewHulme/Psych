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
end
