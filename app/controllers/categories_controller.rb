class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    if params[:categories]
      puts params[:categories]
    else
      @categories = Category.all
    end

    @categories_details = @categories.map{|category| {category:category, courses: category.courses}}

    render json: @categories_details
  end

  # GET /categories/1
  def show
    render json: {category: @category, courses: @category.courses}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title, :categories)
    end
end
