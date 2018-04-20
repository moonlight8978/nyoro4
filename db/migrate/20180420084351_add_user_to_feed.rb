class AddUserToFeed < ActiveRecord::Migration[5.1]
  def change
    add_reference :feeds, :user
  end
end
