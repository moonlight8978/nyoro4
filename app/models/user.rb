class User < ApplicationRecord
  searchkick highlight: [:username, :profilename], word_middle: [:username, :profilename]

  # value is what others can see
  # @example
  #   ddmmyy  => "18-12-1997"
  #   ddmm    => "18-12"
  enum birthday_visibility: %i(ddmmyy ddmm yy hidden)

  # Use friendly url for profile path
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Accept TOS required for registration
  attr_accessor :accept_tos

  # associations
  has_many :following_statuses, class_name: 'User::Following', foreign_key: :follower_id
  has_many :follower_statuses, class_name: 'User::Following', foreign_key: :user_id

  has_many :followers, through: :follower_statuses do
    # def accepted
    #   includes(:follower_statuses)
    #     .where("user_followings.status": User::Following.statuses[:accepted])
    #     .references(:user_followings)
    # end

    # Fetch followers which are waiting for accepting
    def pending
      includes(:follower_statuses)
        .where("user_followings.status": User::Following.statuses[:pending])
        .references(:user_followings)
    end
  end

  has_many :followings, through: :following_statuses, source: :user do
    # Fetch followings which has been accepted
    def accepted
      includes(:following_statuses)
        .where("user_followings.status": User::Following.statuses[:accepted])
        .references(:user_followings)
    end
    # Fetch followings which waiting for accepting
    def pending
      includes(:following_statuses)
        .where("user_followings.status": User::Following.statuses[:pending])
        .references(:user_followings)
    end
  end

  has_many :likes,    class_name: "Feed::Like"
  has_many :retweets, class_name: "Feed::Retweet"

  has_many :liked_tweets,     class_name: "Feed::Tweet",  source: :likable, through: :likes, source_type: "Feed::Tweet"
  has_many :retweeted_tweets, class_name: "Feed::Tweet",  source: :retweetable, through: :retweets, source_type: "Feed::Tweet"

  has_many :liked_replies,     class_name: "Tweet::Reply", source: :likable, through: :likes, source_type: "Tweet::Reply"
  has_many :retweeted_replies, class_name: "Tweet::Reply", source: :retweetable, through: :retweets, source_type: "Tweet::Reply"

  has_many :mentionings, class_name: "Tweet::Mentioning"
  has_many :mentioned_tweets, class_name: "Feed::Tweet", source: :mentionable, through: :mentionings,
  source_type: "Feed::Tweet"
  has_many :mentioned_replies, class_name: "Tweet::Reply", source: :mentionable, through: :mentionings,
  source_type: "Tweet::Reply"
  # scopes

  # class methods
  # Suggest users to follow, max is 3
  def self.suggestions_for(user)
    exclude_ids = user.followings.pluck(:id) << user.id
    User.where.not(id: exclude_ids)
      .order("RANDOM()").limit(5)
  end

  # validates
  # Require "yes" value at registration
  validates :accept_tos, presence: true, inclusion: %w(yes), on: :create
  # Profilename is required
  validates :profilename, presence: true
  # Username is required and is unique, User can use this to access profile
  validates :username, presence: true, uniqueness: true

  # callbacks

  # instance methods
end
