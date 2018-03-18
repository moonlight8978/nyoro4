class AddPhotosAndVideosToFeedTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :feed_tweets, :photos, :json
    add_column :feed_tweets, :video, :string
  end
end
