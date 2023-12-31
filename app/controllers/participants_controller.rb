class ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversation = Conversation.find(params[:conversation_id])
    @participants = @conversation.participants

    render json: { participants: @participants }
  end

  private

  def locutor_params
    params.require(:participant).permit(:user_id, :conversation_id)
  end
end
