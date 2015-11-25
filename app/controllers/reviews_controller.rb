class ReviewsController < ApplicationController  
  before_action :require_user
  before_action :set_current_recipe
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(body: params[:review][:body], recipe: @recipe, chef: current_user)
    if @review.save
      flash[:success] = "Review for '#{@recipe.name}' created"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def destroy
    if !current_user.admin?
      redirect_to recipe_path(@recipe)
    end
    Review.find(params[:id]).destroy
    flash[:success] = "Recipe deleted"
    redirect_to recipe_path(@recipe)
  end

  private
    def set_current_recipe
      @recipe = Recipe.find_by_id(params[:recipe_id]) or not_found
    end
end