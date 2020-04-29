class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User', :foreign_key => :from_id
    belongs_to :reciever, class_name: 'User', :foreign_key => :to_id
    
end
