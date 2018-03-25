class Tweet::Reply < ApplicationRecord
  has_many :likes, class_name: "Feed::Like", as: :likable
  has_many :retweets, class_name: "Feed::Retweet", as: :retweetable
  has_many :replies, class_name: "Tweet::Reply", foreign_key: :root_id
  belongs_to :root, class_name: "Tweet::Reply", optional: true
  belongs_to :user, class_name: "User"
  belongs_to :tweet, class_name: "Feed::Tweet"

  scope :root, -> { where(root_id: nil) }
end
