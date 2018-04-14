class Tweet::Tagging < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :reply,
    foreign_key: :taggable_id,
    foreign_type: 'Tweet::Reply',
    class_name: 'Tweet::Reply',
    optional: true
  belongs_to :tweet,
    foreign_key: :taggable_id,
    foreign_type: 'Feed::Tweet',
    class_name: 'Feed::Tweet',
    optional: true
  belongs_to :hashtag, class_name: 'Tweet::Hashtag'

  def self.tag(taggable)
    taggable.extract_hashtags.map do |name|
      hashtag = Tweet::Hashtag.find_or_create_by(name: name)
      self.create(hashtag: hashtag, taggable: taggable)
    end
  end
end
