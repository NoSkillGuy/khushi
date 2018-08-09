class EventsController < ApplicationController
	before_action :user_logged_in, only: [:index]

	def index
		@user = User.find(params[:user_id])
		if @user.admin?
			whatspp_message_ids = WhatsppMessages.all.pluck(:id)
		else
			whatspp_message_ids = @user.whatspp_messages.pluck(:id)
		end
		output_arr = []
		Event.categories.each do |c,v|
		  category_hash = {}
		  category_hash[:name] = c
		  category_hash[:data] = Event.where(category: c).where(whatspp_message_id: whatspp_message_ids).group_by_minute(:created_at).count
		  output_arr.push category_hash
		end
		respond_to do |format|
			format.json { render json: output_arr }
    end
	end
end