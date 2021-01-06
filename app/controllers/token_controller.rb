class TokenController < ApplicationViewController
  def visitor_key
    user = User.find_or_create_by(visitor_key: params[:token])

    render json: { visitor_key: user.visitor_key }, status: :ok
  end
end
