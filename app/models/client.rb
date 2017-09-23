class Client < ApplicationRecord
  belongs_to :channel

  validates :fname, :lname, :folio, :street, :neighborhood, :city, :zipcode, :house_phone, 
            :mobile_phone, :age, :tutor_name, :contact_date, :observations, presence: true

  validates :age, :zipcode, numericality: { only_integer: true, greater_or_equal_than: 0 }

  validates_date :contact_date, on_or_before: lambda { Date.today },
                                on_or_before_message: "debe ser antes de mañana"
end
