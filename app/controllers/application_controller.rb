class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :store_request_url, only: [:destroy]

  def store_request_url
    session[:return_to] = request.referer
  end
end
