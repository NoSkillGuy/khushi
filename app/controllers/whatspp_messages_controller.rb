class WhatsppMessagesController < ApplicationController
  before_action :set_whatspp_message, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /whatspp_messages
  # GET /whatspp_messages.json
  def index
    @whatspp_messages = WhatsppMessage.all
  end

  # GET /whatspp_messages/1
  # GET /whatspp_messages/1.json
  def show
  end

  # POST /whatspp_messages
  # POST /whatspp_messages.json
  def create
    @user = User.where(phone_number: params['From'].split(':').second).first
    if @user.present?
      @whatspp_message = WhatsppMessage.new(user_id: @user.id, data: params['Body'])
      respond_to do |format|
        if @whatspp_message.save
          format.json { render :show, status: :created, location: @whatspp_message }
        else
          format.json { render json: @whatspp_message.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: @whatspp_message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_whatspp_message
      @whatspp_message = WhatsppMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def whatspp_message_params
      params.require(:whatspp_message).permit(:data, :user_id, :spam)
    end
end
