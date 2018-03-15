class FollowingService::Destroy
  def initialize(**args)
    @user = args[:user]
    @follower = args[:follower]
  end

  def perform
    User::Following
      .where(user: @user, follower: @follower)
      .destroy_all
  end
end
