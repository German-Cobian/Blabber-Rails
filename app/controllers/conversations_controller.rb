class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.all

    render json: { conversations: @conversations }
  end

  def show
    @conversation = Conversation.find(params[:id])

    render json: { conversation: @conversation }
  end

  def create
    @conversation = current_user.conversations.build(conversation_params)

    if @conversation.save
      render json: { conversation: @conversation }
    else
      render json: { error: 'Failed to create conversation' }, status: :unprocessable_entity
    end
  end

  def destroy
   
    conversation = current_user.conversations.find(params[:id])

      if conversation.nil?
        render status: 404, json: { error: 'Conversation not found' }.to_json
      else
        conversation.destroy
        render json: { message: 'Conversation deleted' }.to_json
      end
  end


  private

  def conversation_params
    params.require(:conversation).permit(:title, :user_id)
  end
end
