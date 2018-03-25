class Feed::Like < ApplicationRecord
  include Feed::React
  belongs_to :likable, polymorphic: true
  belongs_to :tweet,
    foreign_key: :likable_id,
    foreign_type: "Feed::Tweet",
    class_name: "Feed::Tweet",
    optional: true
  belongs_to :reply,
    foreign_key: :likable_id,
    foreign_type: "Tweet::Reply",
    class_name: "Tweet::Reply",
    optional: true
end
