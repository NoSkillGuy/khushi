class WhatsppMessagesController < ApplicationController
  before_action :user_logged_in, only: [:index]
  before_action :set_whatspp_message, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /whatspp_messages
  # GET /whatspp_messages.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: WhatsppMessagesDatatable.new(view_context,@user) }
    end
  end
  
  # POST /whatspp_messages
  # POST /whatspp_messages.json
  def create
    require 'despamilator'
    if Despamilator.new(params['Body']).score < 0.8
      @user = User.where(phone_number: params['From'].split(':').second).first
      if @user.present? && @user.verified_phone_number
        @whatspp_message = WhatsppMessage.new(user_id: @user.id, data: params['Body'])
        respond_to do |format|
          if @whatspp_message.save
            @whatspp_message.set_events
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
    else
      respond_to do |format|
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end
end
