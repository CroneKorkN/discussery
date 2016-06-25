class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorize
  before_action :require_login, except: [:login, :signup]
  layout proc { false if request.xhr? }
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def authorize(action, category)
    begin
      raise Exceptions::AuthorizationError.new unless current_user.acl.allows? action, category
    rescue Exceptions::AuthorizationError
      render text: "category #{category.id} authorization error: #{current_user.name} #{action}"
    end
  end

  private

  def require_login
    redirect_to login_url unless current_user
  end
end
