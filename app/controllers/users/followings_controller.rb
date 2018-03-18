class Users::FollowingsController < ApplicationController
  # Only signed users can access these routes
  before_action :authenticate_user!

  # Refresh the suggestions box
  # @return [String] html string for new suggestions box
  # @note Should use AJAX
  def index
    #code
  end

  # Controller to follow someone
  # @note Should use AJAX
  def create
    follower = current_user
    user = User.find(params[:user_id])
    form = FollowingForm.new(follower: follower, user: user)

    if form.valid?
      service = FollowingService::Create.new(follower, user)
      service.perform

      head :ok
    else
      head :bad_request
    end
  end

  # Controller to follow someone
  # @note Should use AJAX
  def destroy
    follower = current_user
    user = User.find(params[:user_id])

    service = FollowingService::Destroy.new(follower, user)
    service.perform

    head :ok
  end
end
