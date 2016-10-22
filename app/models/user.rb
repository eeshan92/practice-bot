class User < ApplicationRecord
  acts_as_token_authenticatable
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :invite_code

  validates :invite_code,
    on: :create,
    presence: true,
    inclusion: {
      in: ["never enough"],
      message: "Invalid invite code"
    }
end
