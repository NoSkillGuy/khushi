class WhatsppMessagesController < ApplicationController
  before_action :set_whatspp_message, only: [:show, :edit, :update, :destroy]

  # GET /whatspp_messages
  # GET /whatspp_messages.json
  def index
    @whatspp_messages = WhatsppMessage.all
  end

  # GET /whatspp_messages/1
  # GET /whatspp_messages/1.json
  def show
  end

  # GET /whatspp_messages/new
  def new
    @whatspp_message = WhatsppMessage.new
  end

  # GET /whatspp_messages/1/edit
  def edit
  end

  # POST /whatspp_messages
  # POST /whatspp_messages.json
  def create
    @whatspp_message = WhatsppMessage.new(whatspp_message_params)

    respond_to do |format|
      if @whatspp_message.save
        format.html { redirect_to @whatspp_message, notice: 'Whatspp message was successfully created.' }
        format.json { render :show, status: :created, location: @whatspp_message }
      else
        format.html { render :new }
        format.json { render json: @whatspp_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /whatspp_messages/1
  # PATCH/PUT /whatspp_messages/1.json
  def update
    respond_to do |format|
      if @whatspp_message.update(whatspp_message_params)
        format.html { redirect_to @whatspp_message, notice: 'Whatspp message was successfully updated.' }
        format.json { render :show, status: :ok, location: @whatspp_message }
      else
        format.html { render :edit }
        format.json { render json: @whatspp_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /whatspp_messages/1
  # DELETE /whatspp_messages/1.json
  def destroy
    @whatspp_message.destroy
    respond_to do |format|
      format.html { redirect_to whatspp_messages_url, notice: 'Whatspp message was successfully destroyed.' }
      format.json { head :no_content }
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
