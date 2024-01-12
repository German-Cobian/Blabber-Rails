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
    # Fetch the users
    user_1 = current_user
    user_2 = User.find(params[:conversation][:user_id])
    
    title_1 = user_1.username
    title_2 = user_2.username
    @conversation = Conversation.new(title_1: title_1, title_2: title_2, user: user_1)

    # Build participants for the conversation
    @conversation.participants.build(user: user_1)
    @conversation.participants.build(user: user_2)

    if @conversation.save
      # Fetch the participants after the conversation is saved
      participant_1 = @conversation.participants.find_by(user: user_1)
      participant_2 = @conversation.participants.find_by(user: user_2)
      
      render json: { conversation: @conversation, participants: [participant_1, participant_2] }
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
    params.require(:conversation).permit(:title_1, :title_2, :user_id)
  end
end
