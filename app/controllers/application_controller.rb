class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def permission_denied!(ex)
  	flash[:alert] = "You are not allowed!"
  	redirect_to root_url
  end

end
