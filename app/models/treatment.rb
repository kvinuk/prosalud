class Treatment < ApplicationRecord
  belongs_to :client
  belongs_to :therapist
  belongs_to :service
end
