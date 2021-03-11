class Api::ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user
  end

  def update
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:profile).permit(:first_name, :last_name)
  end

end
