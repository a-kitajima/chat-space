class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :messages
  has_many :groups_users
  has_many :groups, through: :groups_users
  def print_name
    "#{name}"
  end

  def self.search(search)
    User.where('name LIKE(?)', "%#{search}%")
  end
end
