class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.string :from_id
      t.string :to_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
