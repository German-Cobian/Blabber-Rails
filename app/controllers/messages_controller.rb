class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:create]

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
    #@messages = Message.all 

    render json: { messages: @messages }
  end

  def show 
    @message = Message.find(params[:id])

    render json: { message: @message }
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      render json: { message: @message }
    else
      render json: { error: 'Failed to create message' }, status: :unprocessable_entity
    end
  end


  def update
    @message = current_user.messages.find(params[:id])

 
    if @message.update(message_params)
      render json: { message: @message }
    else
      render status: 404, json: { error: 'Message not found' }.to_json
    end
  end

  def destroy
    @message = current_user.messages.find(params[:id])
  
    
    if @message.nil?
      render status: 404, json: { error: 'Message not found' }.to_json
    else
      @message.destroy
      render json: { message: 'Message deleted' }.to_json
    end
  end


private
  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id)
  end

  def authorize_user
    @conversation = Conversation.find(params[:conversation_id])

    if !@conversation.participants.exists?(user_id: current_user.id)
      render json: { error: 'You are not authorized to post messages in this private room' }, status: :forbidden
    end
  end
end
