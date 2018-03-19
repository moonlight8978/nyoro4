class CreateFeedTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_tweets do |t|
      t.belongs_to  :user
      t.text        :content
      t.boolean     :pinned,          default: false
      t.integer     :replies_count,   default: 0
      t.integer     :likes_count,     default: 0
      t.integer     :retweets_count,  default: 0

      # Tweet medias
      t.json        :photos
      t.string      :video

      # Dimensions of photos, seperate by ","
      t.string      :widths,          default: ""
      t.string      :heights,         default: ""

      t.timestamps
    end

    add_index :feed_tweets, :pinned
  end
end
