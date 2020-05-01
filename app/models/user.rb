class User < ApplicationRecord
  has_many :outgoing, class_name: 'FriendRequest', foreign_key: "from_id"
  has_many :incomming, class_name: 'FriendRequest', foreign_key: "to_id"

  has_many :posts, class_name: 'Post', foreign_key: "creator_id"
  has_many :comments

  has_one_attached :image


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if !auth.info.email.nil?
        user.email = auth.info.email
      else
        user.email = "not_found_#{User.all.count+1}@email.com"
      end
      user.password = Devise.friendly_token[0, 20]
      name = auth.info.name.split(" ")
      user.first_name = name[0]
      if !name[1].nil?
        user.last_name = name[1]
      end
    end
  end

  after_create :send_welcome_email

  def send_welcome_email
    WeclomeMailer.send_welcome_email(self).deliver
  end
end