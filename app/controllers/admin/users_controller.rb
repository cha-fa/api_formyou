class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all

    render json: @users
  end

  private

end
