class Listing < ApplicationRecord
  include PgSearch

  pg_search_scope :similar_to, 
                  :against => [:city, :title]
                  #:using => :trigram
                  

  belongs_to :user
  has_many :tags, through: :listing_tags
  has_many :listing_tags, :dependent => :destroy
  has_many :reservations
  mount_uploaders :photos , PhotoUploader

  


  #scope :rescent, -> {order("created_at DESC")}
  #scope :tag,     -> (tag) { where tag: tag }

  # scope :city,    -> (city) { where city: city }
  # scope :price,    -> (price) { where price: price }

  # def self.search(term)
  #  where("city like :term", term: "#{term}")
  # end
end
