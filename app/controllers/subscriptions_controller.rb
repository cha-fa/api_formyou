class SubscriptionsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :user_is_approved
  before_action :set_subscription, only: [:show, :update, :destroy]
  before_action :check_if_allowed

  # GET /subscriptions
  def index
    if params[:student]
      @subscriptions = @user.subscriptions.map{|sub| {subscription: sub, promotion:sub.promotion, course: sub.promotion.course, seat_left: sub.promotion.remaining_seats}}
    else
      @subscriptions = @user.subscriptions
    end
    render json: @subscriptions
  end

  # GET /subscriptions/1
  def show
    render json: @subscription
  end

  # POST /subscriptions
  def create
    @promotion = Promotion.find(params[:promotion_id])

    if @promotion.is_full?
      render :json => { errors: "No remaining seat for this date, please choose another." }, :status => 401
    elsif current_user.subscriptions.where(promotion: @promotion).any?
      render :json => { errors: "You are already subscribed to this date." }, :status => 401
    else
      @subscription = Subscription.new(subscription_params)
      @subscription.student = current_user

      if @subscription.save
        render json: @subscription, status: :created, location: url_for([@user, @subscription])
      else
        render json: { errors: @subscription.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  def update
    if @subscription.update(subscription_params)
      render json: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:user_id, :note, :promotion_id)
    end

    def check_if_allowed
      unless current_user == @user || current_user.role === "admin" || current_user.role === "teacher"
        render json: {success: false, error: "You can't see this page"}, status: 401
      end
    end
end
