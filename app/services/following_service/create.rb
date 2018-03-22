module FollowingService
  # Service to create new following
  # Use when user try to follow someone
  class Create
    # @param follower [User] follower
    # @param user [User] user to follow
    def initialize(follower, user)
      @user = user
      @follower = follower
    end

    # Create the following
    def perform
      User::Following.create(user: @user, follower: @follower)
    end
  end
end
