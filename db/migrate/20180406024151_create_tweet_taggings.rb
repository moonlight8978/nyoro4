class CreateTweetTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_taggings do |t|
      t.belongs_to :hashtag
      t.belongs_to :taggable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
