module Feed::React
  extend ActiveSupport::Concern

  included do
    belongs_to :user, class_name: "User"
    has_one :feed, as: :feedable, dependent: :destroy

    def self.reacted_to(tweet)
      where(tweet: tweet)
    end
  end
end
