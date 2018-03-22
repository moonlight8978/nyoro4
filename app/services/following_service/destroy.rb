module FollowingService
  # Service to delete following
  # Use when user try to unfollow someone
  class Destroy
    # @param follower [User] follower
    # @param user [User] user to unfollow
    def initialize(follower, user)
      @follower = follower
      @user = user
    end

    # Delete the following
    def perform
      User::Following
        .where(user: @user, follower: @follower)
        .destroy_all
    end
  end
end
