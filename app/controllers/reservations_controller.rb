class ReservationsController < ApplicationController





	def index
		@reservations = Reservation.all
	end

	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]
		@other_resa = Reservation.where(listing_id: @reservation.listing_id)

		if @other_resa.present?
			@other_resa.each do |resa|
				if @reservation.overlaps?(resa)
						flash[:error] = "Reservation overlaps" 
					 	render :new and return
				end
			end
		end

		if @reservation.save 
			flash[:succes] = "Succefully booked"
			redirect_to  listing_reservations_path(params[:listing_id]) 
		else 
			flash[:error] = "An error occured during the booking" 
	 		render :new and return
	 	end
	end


	private
	def reservation_params
		params.require(:reservation).permit(:start_date,:end_date)
	end

end





#####

# def create
# 		@reservation = current_user.reservations.new(reservation_params)
# 		@reservation.listing_id = params[:listing_id]
# 		@other_resa = Reservation.where(listing_id: @reservation.listing_id)
# 		if @other_resa.nil?
# 			if @reservation.save 
# 				flash[:succes] = "Succefully booked"
# 				redirect_to  listing_reservations_path(params[:listing_id]) 
# 			else 
# 				flash[:error] = "An error occured during the booking" 
# 		 		render :new
# 		 	end
# 		else
# 			@other_resa.each do |resa|
# 			if @reservation.overlaps?(resa)
# 					flash[:error] = "Reservation overlaps" 
# 				 	render :new
# 				else
# 					if @reservation.save 
# 						flash[:succes] = "Succefully booked"
# 						redirect_to  listing_reservations_path(params[:listing_id]) 
# 					else 
# 						flash[:error] = "An error occured during the booking" 
# 				 		render :new
# 				 	end
# 			end
# 			end
# 		end
# 	end
