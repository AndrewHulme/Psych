module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = User.find_or_create_by(visitor_key: cookies[:visitor_key])
    end
  end
end
