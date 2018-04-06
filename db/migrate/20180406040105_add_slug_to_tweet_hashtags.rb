class AddSlugToTweetHashtags < ActiveRecord::Migration[5.1]
  def change
    add_column :tweet_hashtags, :slug, :string
    add_index :tweet_hashtags, :slug
  end
end
