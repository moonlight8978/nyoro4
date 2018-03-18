class Feed::Tweet < ApplicationRecord
  mount_uploaders :photos, PhotoUploader
  mount_uploader  :video,  VideoUploader
  # associations
  belongs_to :user, class_name: "User"
  has_one :feed, as: :feedable
  # scopes
  # class methods
  # validates
  # callbacks
  after_initialize :set_defaults

  def set_defaults
    self.pinned = false
    self.likes_count = 0
    self.retweets_count = 0
    self.replies_count = 0
  end
  # instance methods
end
