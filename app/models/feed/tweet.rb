class Feed::Tweet < ApplicationRecord
  mount_uploaders :photos, PhotoUploader
  mount_uploader  :video,  VideoUploader
  # associations
  belongs_to :user, class_name: "User"
  has_one :feed, as: :feedable, dependent: :destroy
  has_many :retweets, class_name: "Feed::Retweet"
  has_many :likes, class_name: "Feed::Like", as: :likable
  has_many :retweets, class_name: "Feed::Retweet", as: :retweetable
  has_many :replies, -> { root.order(created_at: :asc) }, class_name: "Tweet::Reply"
  # scopes
  # class methods
  # validates
  # callbacks
  # instance methods
end
