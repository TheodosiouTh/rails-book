class User < ApplicationRecord
  has_many :outgoing, class_name: 'FriendRequest', :foreign_key => :from_id
  has_many :incomming, class_name: 'FriendRequest', :foreign_key => :to_id

  has_many :posts, class_name: 'Post', :foreign_key => :creator_id

  has_one_attached :image


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end