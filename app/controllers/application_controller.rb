class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '400'
        }
      ]
    }, status: :bad_request
  end

  def authenticate_admin
    unless current_user.role === "admin" && current_user.is_approved
      render json: {success: false, error: "You are not allowed to't see this page"}, status: 401
    end
  end

  def user_is_approved
    unless current_user.is_approved
      render json: {success: false, error: "You can't see this page"}, status: 401
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :role)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :role)}
  end

end

kk
