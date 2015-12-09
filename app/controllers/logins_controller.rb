class LoginsController < ApplicationController
  include ApplicationHelper
  
  def new
    redirect_to recipes_path if logged_in?
  end
  
  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
        sign_in chef
        flash[:success] = "You are login " + chef.chefname
        redirect_to recipes_path
    else
      flash.now[:danger] = "Bad identifiants"
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to :back
  end
  
end