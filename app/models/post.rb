class Post < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: "creator_id"

    has_many :comments
    #The post can also have an image
end
