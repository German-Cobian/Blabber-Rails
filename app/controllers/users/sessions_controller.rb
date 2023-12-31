# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json
  before_action :check_user_enabled, only: [:create]
  private

  def check_user_enabled
    user = User.find_by(email: params[:user][:email])

    if user && user.disabled?
      render json: {
        status: 401,
        message: "Your account is disabled. Please contact the administrator."
      }, status: :unauthorized
    end
  end

  def respond_with(resource, _opts = {})
    render json: {
      status: {code: 200, message: 'Logged in sucessfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
