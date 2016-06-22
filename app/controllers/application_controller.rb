class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout proc{|c| c.request.xhr? ? false : "application" }
  #before_action :authenticate!, except: [:new]
  helper_method :current_user, :authorize
  before_action :require_login

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # first arg: ommit or user; second arg: `action: object`
  def authorize(*args)
    user, action, object = extract_authorization_arguments(args)
    p "######## #{user} #{action} #{object}"
    begin
      Authorization.new user, action, object
    rescue Exceptions::AuthorizationError
      render text: "Prohibited"
    end
  end

  def authenticate!
    redirect_to ""
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
