class FollowingForm < ApplicationForm
  attr_accessor :follower, :user

  delegate :follower_id, :user_id, :status, to: :following

  def following
    @following ||= User::Following.new(follower: follower, user: user)
  end

  def valid?
    existed = User::Following.exists?(follower: follower, user: user)
    !existed
  end
end
