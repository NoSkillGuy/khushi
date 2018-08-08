class ApplicationController < ActionController::Base
	# def user_logged_in
 #    if session[:user_id].present?
 #      @user = User.where(id: session[:user_id]).first
 #      return true if @user
 #    end
 #    redirect_to root_path, flash: { error: 'You have to login!' }
 #  end
 	def user_logged_in
 		@user = User.last
 	end
end
