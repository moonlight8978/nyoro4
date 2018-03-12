class User < ApplicationRecord
  enum birthday_visibility: %i(ddmmyy ddmm yy hidden)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :accept_tos

  # associations
  has_many :following_statuses, class_name: 'FollowingStatus', foreign_key: :follower_id
  has_many :follower_statuses, class_name: 'FollowingStatus', foreign_key: :following_id

  has_many :followers, through: :follower_statuses do
    def accepted
      includes(:follower_statuses)
        .where("user_following_statuses.status": User::FollowingStatus.statuses[:accepted])
        .references(:user_following_statuses)
    end

    def pending
      includes(:follower_statuses)
        .where("user_following_statuses.status": User::FollowingStatus.statuses[:pending])
        .references(:user_following_statuses)
    end
  end

  has_many :followings, through: :following_statuses do
    def accepted
      includes(:following_statuses, :followings)
        .where("user_following_statuses.status": User::FollowingStatus.statuses[:accepted])
        .references(:user_following_statuses)
    end

    def pending
      includes(:following_statuses, :followings)
        .where("user_following_statuses.status": User::FollowingStatus.statuses[:pending])
        .references(:user_following_statuses)
    end
  end

  # scopes

  # class methods
  def self.suggestions_for(user)
    # offset(rand(User.count) - 3)
    User.where.not(id: user.id).order("RANDOM()").limit(3)
  end

  # validates
  validates :accept_tos, presence: true, inclusion: %w(yes), on: :create
  validates :profilename, presence: true
  validates :username, presence: true, uniqueness: true
  
  # callbacks

  # instance methods
end
