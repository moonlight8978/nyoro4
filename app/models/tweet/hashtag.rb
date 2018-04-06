class Tweet::Hashtag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :taggings, class_name: 'Tweet::Tagging'
  has_many :tweet_taggings, -> { where(taggable_type: 'Feed::Tweet') }, class_name: 'Tweet::Tagging'
  has_many :reply_taggings, -> { where(taggable_type: 'Tweet::Reply') }, class_name: 'Tweet::Tagging'
  has_many :tweets,
    through: :tweet_taggings, class_name: 'Feed::Tweet'

end
