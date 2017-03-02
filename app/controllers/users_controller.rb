class UsersController < Clearance::UsersController

  def index
    @listings = Listing.all.order("created_at DESC").page(params[:page]).per(6)

     # @listings = Listing.search(params[:search]) unless params[:search].blank?
     # @listings = @listings.city unless params[:city].blank?

    # @Listings = Listing.all 
    # @Listings = @listings.city(params[:city]) if params[:city].present?
    # @Listings = @listings.price(params[:price]) if params[:price].present?
    # @listings = @Listings.all.order("created_at DESC").page(params[:page]).per(6)

    @listings = @listings.similar_to(params[:query]) if params[:query].present?
    



    #if params[:city]
      #@Listings = Product.where(nil)
      #@listing = @listing.status(params[:tag]) if params[:tag].present?
      #@Listings = @listings.city(params[:city]) if params[:city].present?
      #@listings = Listing.city

      #@listing = @listing.starts_with(params[:starts_with]) if params[:starts_with].present?
    #end

  end

  def show
    @listings = Listing.all

  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserNotifierMailer.send_signup_email(@user).deliver

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
