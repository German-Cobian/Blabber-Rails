class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all

    render json: UserSerializer.new(@users).serializable_hash[:data], status: :ok
  end

  def show
    @user = User.find(params[:id])

    if @user.nil?
      render status: 404, json: { error: 'User not found' }.to_json
    else
      render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :ok
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update

    if current_user.admin?
      @user = User.find_by(id: params[:id])

      if @user.update(user_params)
        render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end

  def destroy

    if current_user.admin?
    user = User.find_by(id: params[:id])

      if user.nil?
        render status: 404, json: { error: 'User not found' }.to_json
      else
        user.destroy
        render json: { message: 'User deleted' }.to_json
      end
    else
      render json: { message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :is_enabled, :role)
  end
end
