module ProfilesHelper
  def profile_path?(user)
    current_page?(profile_path(user))
  end

  def profile_following_path?(user)
    current_page?(profile_following_path(user))
  end

  def profile_followers_path?(user)
    current_page?(profile_followers_path(user))
  end

  def profile_likes_path?(user)
    current_page?(profile_likes_path(user))
  end
end
