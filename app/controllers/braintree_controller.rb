class BraintreeController < ApplicationController

  def new
    
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:reservation_id].to_i) 
  end

  def checkout
  
    @reservation = Reservation.find(params[:checkout_form][:reservation_id].to_i)
    listing = @reservation.listing
    length_stay = @reservation.end_date - @reservation.start_date
    price = listing.price * length_stay.to_i
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    result = Braintree::Transaction.sale(
     :amount => price, #this is currently hardcoded
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      @reservation.paid!
      
      redirect_to listing_reservations_path(listing.id), :flash => { :success => "Transaction successful!" }
    else
      redirect_to new_listing_reservation_path(listing.id), :flash => { :error => "Transaction failed. Please try again." }
    end 
  end



end
