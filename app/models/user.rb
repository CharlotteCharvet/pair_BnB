class User < ApplicationRecord

  include Clearance::User

  has_many :authentications, :dependent => :destroy
  has_many :listings
  has_many :reservations

  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(name: auth_hash["info"]["name"], email: auth_hash["extra"]["raw_info"]["email"])
      user.authentications << (authentication)
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

end
