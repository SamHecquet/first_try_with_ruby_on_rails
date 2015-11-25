class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :set_recipe
  
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
      !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged to perform this action"
      redirect_to recipes_path
    end
  end

  def set_recipe
    @recipe = Recipe.find_by_id(params[:id]) or not_found
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
end
