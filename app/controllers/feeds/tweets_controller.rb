class Feeds::TweetsController < ApplicationController
  def show
    #code
  end

  # User submit tweet
  def create
    form = TweetForm.from_params(current_user, params)

    if form.valid?
      TweetService::Create.new(current_user, form.tweet).perform
      head :ok
    else
      head :bad_request
    end
  end

  def update
    #code
  end

  def destroy
    #code
  end
end
