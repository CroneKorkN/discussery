class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorize
  before_action :require_login, except: [:login, :signup]
  #before_action :mobile_device? # define @mobile_device for scss
  layout proc{ false if request.xhr? }
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def authorize(*args)
    user, action, object = auth_params args
    begin
      raise Exceptions::AuthorizationError.new unless current_user.may? action, object
    rescue Exceptions::AuthorizationError
      render plain: "#{object.class.name} #{object.id} authorization error: #{current_user.name} #{action}"
    end
  end

  def mobile_device?
    @mobile_device ||= request.user_agent.include? "Mobile"
  end
  helper_method :mobile_device?

  private

  def require_login
    redirect_to login_url unless current_user
  end
  
  def auth_params args 
    # user?
    user = if args.first.is_a? User
      args.shift
    else
      current_user
    end
    
    # global?
    if args.first.is_a? Symbol
      action = args.first
      object = :global
    elsif args.first.is_a? Hash
      action = args.first.keys.first.to_sym
      object = args.first.values.first
    end
    
    return [user, action, object]
  end
end
