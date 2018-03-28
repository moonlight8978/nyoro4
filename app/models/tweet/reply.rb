class Tweet::Reply < ApplicationRecord
  mount_uploaders :photos, PhotoUploader
  mount_uploader  :video,  VideoUploader

  has_many :likes, class_name: "Feed::Like", as: :likable
  has_many :retweets, class_name: "Feed::Retweet", as: :retweetable
  has_many :replies, -> { order(created_at: :asc) }, class_name: "Tweet::Reply", foreign_key: :root_id
  has_many :nexts, class_name: "Tweet::Reply", foreign_key: :previous_id
  belongs_to :root, class_name: "Tweet::Reply", optional: true
  belongs_to :user, class_name: "User"
  belongs_to :tweet, class_name: "Feed::Tweet"
  belongs_to :previous, class_name: "Tweet::Reply", optional: true

  scope :root, -> { where(root_id: nil) }
end
