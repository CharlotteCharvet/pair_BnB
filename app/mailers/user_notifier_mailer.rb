class UserNotifierMailer < ApplicationMailer
  default :from => 'chacharvet@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_reservation_email(user)
    @user = user
    mail( :to =>  @user,
    :subject => 'Thanks for making a reservation on this amazing property' )
  end
end
