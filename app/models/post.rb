class Post < ApplicationRecord
    belongs_to :user, class_name: 'User', :foreign_key => :creator_id

    #The post can also have an image
    has_one_attached :image
end
