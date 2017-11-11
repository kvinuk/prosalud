class User < ApplicationRecord
  rolify
  has_one :therapist

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  after_save :update_role

  def self.types
    %w[Administrador Recepcionista Psicologo Nutriologo]
  end

  def update_role
    case role_type
      when "Administrador"
        self.add_role :admin
      when "Recepcionista"
        self.add_role :receptionist
      when "Psicologo"
        self.add_role :therapist
        Therapist.create(user: self, therapist_type: "psicologo")
      when "Nutriologo"
        self.add_role :therapist 
        Therapist.create(user: self, therapist_type: "nutriologo")
    end
  end

end
