class User::Following < ApplicationRecord
  enum status: [:pending, :accepted]

  belongs_to :user, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  after_initialize :set_defaults

  def set_defaults
    self.status = :accepted
  end
end
