class UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.all

    render json: @users
  end

  private

end
