class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :update, :destroy]
  def index
    if params[:is_reviewed]
      @users = User.to_review
    else
      @users = User.all
    end
    render json: @users
  end

  def update
    if @user.update(user_params)
      @user.update(is_reviewed: true)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
   @user.destroy
  end 
      

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:is_approved)
  end

end
