class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes=Recipe.all.order 'created_at DESC'
  end

  def show

  end

  def new
    @recipe=current_user.recipes.build
  end

  def create
    @recipe=current_user.recipes.build recipe_params
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe created'
    else
      flash.now[:alert]='Could not save recipe'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update recipe_params
      redirect_to @recipe, notice: 'Recipe updated'
    else
      render :edit
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to root_path, notice: 'Recipe deleted'
    else
      redirect_to :back, alert: 'Could not delete recipe. Check errors below:'
    end
  end


  private
  def set_recipe
    @recipe=Recipe.find params[:id]
  end

  def recipe_params
    params.require(:recipe).permit :title, :description, :image, ingredients_attributes: [:id, :name, :_destroy],
                                                                 directions_attributes: [:id, :step, :_destroy]
  end
end
