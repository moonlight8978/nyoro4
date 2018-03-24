class CreateFeedReacts < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_likes do |t|
      t.belongs_to :user
      t.references :likable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :feed_likes, [:user_id, :likable_id, :likable_type], name: :feed_likes_likeable

    create_table :feed_retweets do |t|
      t.belongs_to :user
      t.references :retweetable, polymorphic: true, index: true

      t.timestamps
    end

    add_index :feed_retweets, [:user_id, :retweetable_id, :retweetable_type], name: :feed_retweets_retweetable
  end
end
