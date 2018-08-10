class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_logged_in
  before_action :load_whatspp_message_ids
  # layout :resolve_layout
  # GET /users/1
  # GET /users/1.json
  def show
    @event_data_by_category_and_minute = Event.where(whatspp_message_id: @whatspp_message_ids).group(:category).group_by_minute(:created_at).count
    @event_data_by_category = Event.where(whatspp_message_id: @whatspp_message_ids).group(:category).count
  end

  def events_count
    event_data = Event.where(whatspp_message_id: @whatspp_message_ids).group(:category).group_by_minute(:created_at).count.count
    respond_to do |format|
      format.json { render json: event_data }
    end    
  end

  def event_data_by_category_and_minute
    event_data_by_category_and_minute = Event.where(whatspp_message_id: @whatspp_message_ids).group(:category).group_by_minute(:created_at).count
    respond_to do |format|
      format.json { render json: JSON.parse(event_data_by_category_and_minute.chart_json) }
    end    
  end

  def events_by_category_data
    event_data_by_category = Event.where(whatspp_message_id: @whatspp_message_ids).group(:category).count
    respond_to do |format|
      format.json { render json: event_data_by_category }
    end
  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  # def edit
  # end

  # # POST /users
  # # POST /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    # def user_params
    #   params.require(:user).permit(:first_name, :second_name, :email, :role)
    # end

    # def resolve_layout
    #   case action_name
    #   when 'new'
    #     'devise'
    #   else
    #     'application'
    #   end
    # end
    def load_whatspp_message_ids
      if @user.admin?
        @whatspp_message_ids = WhatsppMessage.all.pluck(:id)
      else
        @whatspp_message_ids = @user.whatspp_messages.pluck(:id)
      end
    end
end
