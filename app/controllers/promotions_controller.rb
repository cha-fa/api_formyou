class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show]
  before_action :user_is_approved

  # GET /promotions
  def index
    if params[:course_id]
      @course = Course.find(params[:course_id])
      @promotions = @course.promotions
    else
      @promotions = Promotion.all
    end
    @detailed_promotions = @promotions.map{ |promo| promo.with_details }
    render json: @detailed_promotions
  end

  # GET /promotions/1
  def show
    render json: @promotion.with_details
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def promotion_params
      params.require(:promotion).permit(:title)
    end

end
