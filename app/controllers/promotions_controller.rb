class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :update, :destroy]
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  before_action :user_is_approved


  # GET /promotions
  def index
    if params[:teacher_id]
      @promotions = Promotion.teacher(params[:teacher_id]) 
    elsif params[:course_id]
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
    if params[:student]
      @students = @promotion.students
    end
    if params[:subscription]
      @subscriptions = @promotion.subscriptions
      @detailed_subscriptions = @subscriptions.map{ |sub| {subscription: sub, student: sub.student} }
    end

      render json: {promotion: @promotion.with_details, course: @promotion.course, subscriptions: @detailed_subscriptions}
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
      params.require(:promotion).permit(:title)
    end

end
