class Feed::Tweet < ApplicationRecord
  mount_uploaders :photos, PhotoUploader
  mount_uploader  :video,  VideoUploader
  # associations
  belongs_to :user, class_name: "User"
  has_one :feed, as: :feedable, dependent: :destroy
  has_many :retweets, class_name: "Feed::Retweet"
  # scopes
  # class methods
  # validates
  # callbacks
  # instance methods
end
