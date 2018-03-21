class Feed::Like < Feed::React
  belongs_to :user, class_name: "User"
  belongs_to :tweet, class_name: "Feed::Tweet"
  has_one :feed, as: :feedable
end
