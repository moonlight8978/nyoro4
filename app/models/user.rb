class User < ApplicationRecord
  enum birthday_visibility: %i(ddmmyy ddmm yy hidden)

  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :accept_tos

  # associations
  has_many :following_statuses, class_name: 'User::Following', foreign_key: :follower_id
  has_many :follower_statuses, class_name: 'User::Following', foreign_key: :user_id

  has_many :followers, through: :follower_statuses do
    def accepted
      includes(:follower_statuses)
        .where("user_followings.status": User::Following.statuses[:accepted])
        .references(:user_followings)
    end

    def pending
      includes(:follower_statuses)
        .where("user_followings.status": User::Following.statuses[:pending])
        .references(:user_followings)
    end
  end

  has_many :followings, through: :following_statuses, source: :user do
    def accepted
      includes(:following_statuses)
        .where("user_followings.status": User::Following.statuses[:accepted])
        .references(:user_followings)
    end

    def pending
      includes(:following_statuses)
        .where("user_followings.status": User::Following.statuses[:pending])
        .references(:user_followings)
    end
  end

  # scopes

  # class methods
  def self.suggestions_for(user)
    # offset(rand(User.count) - 3)
    # User.where.not(id: user.id).order("RANDOM()").limit(3)
    User.left_joins(:followers)
      .where("user_id IS NULL or user_followings.status = ?", User::Following.statuses[:pending])
      .where.not(id: user.id)
      .order("RANDOM()").limit(5)
  end

  # validates
  validates :accept_tos, presence: true, inclusion: %w(yes), on: :create
  validates :profilename, presence: true
  validates :username, presence: true, uniqueness: true

  # callbacks

  # instance methods
end
