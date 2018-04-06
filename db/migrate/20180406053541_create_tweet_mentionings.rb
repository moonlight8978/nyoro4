class CreateTweetMentionings < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_mentionings do |t|
      t.belongs_to :user
      t.references :mentionable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
