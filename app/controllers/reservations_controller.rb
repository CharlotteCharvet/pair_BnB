class ReservationsController < ApplicationController
include ApplicationHelper




	def index
		@reservations = Reservation.all
		@listing=Listing.find_by(id: params[:listing_id])
	end

	def new
		@reservation = Reservation.new
	end

	def create
		@user = User.find_by(id: current_user.id)	
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
			ReservationJob.perform_later current_user
			flash[:succes] = "Succefully booked, don't forget to proceed to payment"
			redirect_to braintree_new_path({reservation_id: @reservation.id})
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
# 		@user = User.find_by(id: current_user.id)	
# 		@reservation = current_user.reservations.new(reservation_params)

# 		@reservation.listing_id = params[:listing_id]
# 		@other_resa = Reservation.where(listing_id: @reservation.listing_id)

# 		if @other_resa.present?
# 			@other_resa.each do |resa|
# 				if @reservation.overlaps?(resa)
# 						flash[:error] = "Reservation overlaps" 
# 					 	render :new and return
# 				end
# 			end
# 		end




# 		if @reservation.save 
# 			ReservationJob.perform_later current_user
			
# 			flash[:succes] = "Succefully booked"
# 			redirect_to braintree_new_path({reservation_id: @reservation.id})
# 		else 
# 			flash[:error] = "An error occured during the booking" 
# 	 		render :new and return
# 	 	end
# 	end

