class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  # respond_to :json

  before_action :set_cookies

  protected

  def set_cookies
    return if cookies[:visitor_key].present?

    cookies.permanent[:visitor_key] = SecureRandom.hex
  end
end
