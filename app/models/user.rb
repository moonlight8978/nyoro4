class User < ApplicationRecord
  enum birthday_visibility: %i(ddmmyy ddmm yy hidden)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :accept_tos
  # associations
  has_many :followers, through: :following_statuses
  has_many :followings, through: :following_statuses
  # scopes
  # class methods
  # validates
  validates :accept_tos, presence: true, inclusion: %w(yes), on: :create
  # callbacks
  # instance methods
end
