class Feed::Retweet < ApplicationRecord
  include Feed::React
  belongs_to :retweetable, polymorphic: true
  belongs_to :tweet,
    foreign_key: :retweetable_id,
    foreign_type: :retweetable_type,
    class_name: "Feed::Tweet",
    optional: true
  belongs_to :reply,
    foreign_key: :retweetable_id,
    foreign_type: :retweetable_type,
    class_name: "Tweet::Reply",
    optional: true
end
