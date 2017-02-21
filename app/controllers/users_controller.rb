class UsersController < Clearance::UsersController

def create
	@user = User.new(user_params)
	respond_to do |format|
	if @user.save
		format.html { redirect_to sign_in_path, notice: "User was successfully created." }
		# format.js {}
		format.json { render json: @user, status: :created }
	else
		format.html {render action:'new'}
		format.js {}
		format.json { render json: @user.errors, status: :unprocessable_entity }
	end
	end
end

private
def user_params
	params.require(:user).permit(:email, :name, :password)
end

end