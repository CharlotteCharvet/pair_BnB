class Listing < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :listing_tags
  has_many :listing_tags, :dependent => :destroy
  has_many :reservations
  mount_uploaders :photos , PhotoUploader


end
