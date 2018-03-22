class CreateFeedReacts < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_likes do |t|
      t.belongs_to :user
      t.belongs_to :tweet

      t.timestamps
    end

    add_index :feed_likes, [:user_id, :tweet_id]

    create_table :feed_retweets do |t|
      t.belongs_to :user
      t.belongs_to :tweet

      t.timestamps
    end

    add_index :feed_retweets, [:user_id, :tweet_id]
  end
end
