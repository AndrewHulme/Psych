module TestAuthHelper
  def delete_auth_cookies
    cookies.delete "_psych_session"
    cookies.delete "visitor_key"
  end
end
