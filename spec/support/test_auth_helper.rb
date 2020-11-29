module TestAuthHelper
  def delete_auth_cookies
    cookies.delete "_psych_session"
    cookies.delete "visitor_key"
  end

  def current_user
    @current_user ||= User.find_by(visitor_key: cookies[:visitor_key])
  end
end
