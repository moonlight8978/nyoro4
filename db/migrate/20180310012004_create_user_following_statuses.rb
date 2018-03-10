class CreateUserFollowingStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_following_statuses do |t|
      t.belongs_to :following
      t.belongs_to :follower

      t.integer :status

      t.timestamps
    end

    add_index :user_following_statuses, [:following_id, :follower_id],
      name: :following_statuses_following_id_follower_id, unique: true
    add_index :user_following_statuses, [:following_id, :status],
      name: :following_statuses_following_id_status
    add_index :user_following_statuses, [:follower_id, :status],
      name: :following_statuses_follower_id_status
  end
end
