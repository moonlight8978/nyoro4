class Tweet::Mentioning < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :mentionable, polymorphic: true
  belongs_to :tweet, optional: true,
    foreign_key: :mentionable_id,
    foreign_type: 'Feed::Tweet',
    class_name: 'Feed::Tweet'
  belongs_to :reply, optional: true,
    foreign_key: :mentionable_id,
    foreign_type: 'Tweet::Reply',
    class_name: 'Tweet::Reply'
end
