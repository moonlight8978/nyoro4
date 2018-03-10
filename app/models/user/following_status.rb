class User::FollowingStatus < ApplicationRecord
  enum status: [:pending, :accepted]

  belongs_to :following, class: 'User'
  belongs_to :follower, class: 'User'
end
