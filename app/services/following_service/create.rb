class FollowingService::Create
  def initialize(**args)
    @user = args[:user]
    @follower = args[:follower]
  end

  def perform
    User::Following.create(user: @user, follower: @follower)
  end
end
