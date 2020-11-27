module AuthHelper
  extend ActiveSupport::Concern

  included do
    attr_reader :current_user

    before_action :set_cookies
    before_action :set_current_user
  end

  protected

  def set_cookies
    return if cookies[:visitor_key].present?

    cookies.permanent[:visitor_key] = SecureRandom.hex
  end

  def set_current_user
    @current_user ||= User.find_or_create_by(visitor_key: cookies[:visitor_key])
  end
end
