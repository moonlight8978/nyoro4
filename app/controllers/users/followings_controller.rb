class Users::FollowingsController < ApplicationController
  before_action :authenticate_user!

  def index
    #code
  end

  def create
    follower = current_user
    user = User.find(params[:user_id])
    form = FollowingForm.new(follower: follower, user: user)

    if form.valid?
      service = FollowingService::Create.new(user: user, follower: follower)
      service.perform

      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    follower = current_user
    user = User.find(params[:user_id])

    service = FollowingService::Destroy.new(user: user, follower: follower)
    service.perform

    head :ok
  end
end
