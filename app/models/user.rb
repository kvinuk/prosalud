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
        puts "A"
      when "Recepcionista"
        puts "R"
      when "Psicologo"
        puts "P" 
      when "Nutriologo"
        puts "N" 
    end
  end

end
