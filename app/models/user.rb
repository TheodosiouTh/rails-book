class User < ApplicationRecord
  has_many :outgoing, class_name: 'FriendRequest', :foreign_key => :from_id
  has_many :incomming, class_name: 'FriendRequest', :foreign_key => :to_id


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end