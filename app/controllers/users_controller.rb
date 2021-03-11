class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # def show
  #   render json: @user
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:is_approved)
  end

end
