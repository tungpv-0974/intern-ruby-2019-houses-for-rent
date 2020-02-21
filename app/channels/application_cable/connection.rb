module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :message_user

    def connect
      self.message_user = find_verfied_user
    end

    protected

    def find_verfied_user
      user_id = cookies.signed[:user_id] || request.session[:user_id]
      User.find_by(id: user_id) || reject_unauthorized_connection
    end
  end
end
