class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  protect_from_forgery with: :null_session
  helper_method :current_user
  helper_method :api_token_user
  before_action :verify_authentication
  def verify_authentication
    unless api_token_user
      render json: {error: "You don't have permission to access these resources"}, status: :unauthorized
    end
  end

  protected

    def api_token_user
      @api_token_user ||= authenticate_with_http_token do |token, options|
        User.find_by_api_token(token)
      end
    end
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end

