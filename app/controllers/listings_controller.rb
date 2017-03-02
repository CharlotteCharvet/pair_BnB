class ListingsController < ApplicationController


  def index
    

    @listings = Listing.all
      @listing = Listing.where(id: current_user.id)

    

  end

  def show
    @listing = Listing.where(id: current_user.id)

  end

  def new
    @tags = Tag.all
    @listings = Listing.all
    @listing = Listing.new
  end

  def create

    @listing = current_user.listings.new(listing_params)
    if @listing.save
      #ListingTag.new(tag_id: params[:listing][:tag_ids],listing_id: listing.id)
      tag_ids = params[:listing][:tag_ids]
      @listing.tag_ids = tag_ids
      redirect_to user_path(current_user.id)
    else
      render 'new'
    end
  end

  def edit
    @listing = Listing.find_by(id: params[:id])
  end

  def update
    @listing = Listing.find_by(id: params[:id])

    if @listing.update(listing_params)
      tag_ids = params[:listing][:tag_ids]
      @listing.tag_ids = tag_ids
      flash[:succes] = "Succefully updated the listing"
      redirect_to @listing
    else
      flash[:error] = "Error updated your listing" 
      render :edit
    end
  end

  def destroy
    
    @listing = Listing.find_by(id: params[:id])
    @listing.destroy

    redirect_to user_path(current_user.id)
  end


  private
  def listing_params
    params.require(:listing).permit(:title,:description,:city,:address,:price,:max_guests,:start_date,:end_date, photos: [])
  end

  # def ltag_params
  # 	params.require(:listing).permit(:tag_ids,:listing_id)
  # end


end
