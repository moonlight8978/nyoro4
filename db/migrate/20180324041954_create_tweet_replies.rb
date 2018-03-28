class CreateTweetReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_replies do |t|
      t.belongs_to  :user
      t.belongs_to  :root
      t.belongs_to  :tweet
      t.belongs_to  :previous

      t.text        :content
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
  end
end
