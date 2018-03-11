class User::FollowingStatus < ApplicationRecord
  enum status: [:pending, :accepted]

  belongs_to :following, class_name: 'User'
  belongs_to :follower, class_name: 'User'
end
