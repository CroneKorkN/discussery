class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authorize
  before_action :require_login, except: [:login, :signup]
  layout proc { "none" if request.xhr? }

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # first arg: ommit or user; second arg: `action: object`
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

  def extract_authorization_arguments(args)
    # user?
    if args.first.class == "User"
      user = args.shift
    else
      user = current_user
    end
    # global?
    if args.first.is_a? Symbol
      action = args.first
    elsif args.first.is_a? Hash
      action = args.first.keys.first.to_sym
      object = args.first.values.first
    end
    return [user, action, object]
  end
end
