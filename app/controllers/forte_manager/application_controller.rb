module ForteManager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate!

    def authenticate!
      unless params[:token] == ForteManager.secret_token
        head(401)
        false
      end
    end
  end
end
