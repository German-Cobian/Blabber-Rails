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
      render json: user_with_conversations, status: :ok
    end
  end

  def create
    @user = User.new(user_params)
    @participant_user = User.includes(conversations: { participants: :user }).find(params[:id])

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

  def user_with_conversations
    user_data = UserSerializer.new(@user).serializable_hash[:data][:attributes]
    conversations_data = @user.conversations.map do |conversation|
      {
        id: conversation.id,
        title: conversation.title,
        participants: conversation.participants.map do |participant|
          {
            user_id: participant.user.id,
            username: participant.user.username
          }
        end,
        messages: conversation.messages.map do |message|
          {
            id: message.id,
            body: message.body,
            user_id: message.user.id,
            username: message.user.username
          }
        end
      }
    end

    create_conversation_if_none

    user_data.merge(conversations: conversations_data)
  end

  def create_conversation_if_none
    return unless @user.conversations.empty?
    return unless current_user

    conversation_title = "#{current_user.username} & #{@user.username}"

    conversation = Conversation.create(title: conversation_title, user: current_user)
    conversation.participants.build(user: current_user)
    conversation.participants.build(user: @user)
    
    conversation.save
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :is_enabled, :role)
  end
end
