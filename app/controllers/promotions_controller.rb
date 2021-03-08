class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show, :update, :destroy]
  before_action :authenticate_admin, only: [:create, :update, :destroy]

  # GET /promotions
  def index
    @promotions = Promotion.all

    render json: @promotions
  end

  # GET /promotions/1
  def show
    render json: @promotion
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
