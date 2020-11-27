module CookieHelper
  extend ActiveSupport::Concern

  included do
    before_action :set_cookies
  end

  protected

  def set_cookies
    return if cookies[:visitor_key].present?

    cookies.permanent[:visitor_key] = SecureRandom.hex
  end
end
