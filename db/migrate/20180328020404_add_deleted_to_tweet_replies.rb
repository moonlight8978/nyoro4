class AddDeletedToTweetReplies < ActiveRecord::Migration[5.1]
  def change
    add_column :tweet_replies, :deleted, :boolean, default: false
  end
end
