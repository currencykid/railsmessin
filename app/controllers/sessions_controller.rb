class SessionsController < ApplicationController

	def new

	end

	
	
	def create

		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id]  = user.id #saving in session hash, backed by browsers cookies 
			flash[:success] = "You have successfully logged in"
			redirect_to user_path(user) 
		else 
			flash.now[:danger] = "There was something wrong with your login information"
			render 'new' 
		end 
		# debugger
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "Logged out successfully"
		redirect_to root_path

	end

end

