class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  enum status: [:pending, :paid]

   validates_presence_of :start_date, :end_date

  # Check if a given interval overlaps this interval    
  def overlaps?(other)
    (self.start_date - other.end_date) * (other.start_date - self.end_date) >= 0
  end



end
