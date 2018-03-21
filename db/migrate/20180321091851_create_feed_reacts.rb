class CreateFeedReacts < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_reacts do |t|
      t.string :type
      t.belongs_to :user
      t.belongs_to :tweet

      t.timestamps
    end

    add_index :feed_reacts, [:user_id, :tweet_id]
  end
end
