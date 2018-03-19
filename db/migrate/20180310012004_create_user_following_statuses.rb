class CreateUserFollowingStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_followings do |t|
      t.belongs_to :user
      t.belongs_to :follower

      t.integer :status, default: User::Following.statuses[:accepted]

      t.timestamps
    end

    add_index :user_followings, [:user_id, :follower_id],
      name: :followings_user_id_follower_id
    add_index :user_followings, [:user_id, :status],
      name: :followings_user_id_status
    add_index :user_followings, [:follower_id, :status],
      name: :followings_follower_id_status
  end
end
