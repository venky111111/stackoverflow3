class WaysController < ApplicationController
	def index 
	if user_signed_in?
      redirect_to posts_path
    else
      redirect_to landingpage_index_path
	end
end
end
