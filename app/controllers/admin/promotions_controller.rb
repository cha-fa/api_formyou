class Admin::PromotionsController < Admin::BaseController
  before_action :set_promotion, only: [:show, :update, :destroy]

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

  # POST /promotions
  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      render json: @promotion, status: :created, location: @promotion
    else
      render json: @promotion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /promotions/1
  def update
    if @promotion.update(promotion_params)
      render json: @promotion
    else
      render json: @promotion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /promotions/1
  def destroy
    @promotion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def promotion_params
      params.require(:promotion).permit(:classroom_id, :course_id, :start_date)
    end

end
