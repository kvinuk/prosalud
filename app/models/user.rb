class User < ApplicationRecord
  rolify :role_cname => 'Therapist'
  rolify :role_cname => 'Receptionist'
  rolify :role_cname => 'Admin'
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
