class Service < ApplicationRecord
	validates :name, :initial_price, :subsequent_price, :community_price, presence: true	
	has_many :treatments
	validates_numericality_of :initial_price, grater_than_or_equal_to: 0
	validates_numericality_of :subsequent_price, grater_than_or_equal_to: 0
	validates_numericality_of :community_price, grater_than_or_equal_to: 0
	validates_numericality_of :initial_price, only_float: true
	validates_numericality_of :subsequent_price, only_float: true
	validates_numericality_of :community_price, only_float: true
end