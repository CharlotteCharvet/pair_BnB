class ReservationJob < ApplicationJob
  queue_as :default

  def perform(user_id, reservation_id)
    # Do something later

    user = User.find_by(id: user_id)
    #reserva = reservation.find
    UserNotifierMailer.send_reservation_email(user.email).deliver
  end
end
