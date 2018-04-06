class CreateTweetHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_hashtags do |t|
      t.string :name
      t.integer :tweets_count, default: 0
      t.integer :replies_count, default: 0

      t.timestamps
    end
  end
end
