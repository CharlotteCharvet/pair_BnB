class TagsController < ApplicationController
	


	def new
		@tag = Tag.new
	end

	def create
		
		tag = Tag.new(name: params[:name])
		
		if tag.save
			redirect_to new_user_listing_path(current_user.id)
		else
			render 'new'
		end

	end

	private
	def tag_params
		params.require(:tag).permit(:name)
	end
end
