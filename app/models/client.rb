class Client < ApplicationRecord
  belongs_to :channel
  has_many :treatments
  has_many :client_appointments

  validates :fname, :lname, :folio, :street, :neighborhood, :city, :zipcode, :house_phone, 
            :mobile_phone, :age, :tutor_name, :contact_date, presence: true

  validates :age, :zipcode, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates_date :contact_date, on_or_before: -> { Date.today },
                                on_or_before_message: "debe ser antes de mañana"

  def full_name
    fname + " " + lname
  end

  def full_address
    street + ", " + neighborhood + " C.P. " + zipcode.to_s + " " + city
  end
end
