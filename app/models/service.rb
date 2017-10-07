class Service < ApplicationRecord

  has_many :client_appointments

  validates :name, :initial_price, :subsequent_price, :community_price, presence: true
  
  validates_numericality_of :initial_price, greater_than_or_equal_to: 0
  validates_numericality_of :subsequent_price, greater_than_or_equal_to: 0
  validates_numericality_of :community_price, greater_than_or_equal_to: 0
  validates_numericality_of :initial_price
  validates_numericality_of :subsequent_price
  validates_numericality_of :community_price

end
