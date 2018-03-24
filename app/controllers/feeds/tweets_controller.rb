class Feeds::TweetsController < ApplicationController
  # TODO: Edit, update tweet
  decorates_assigned :tweet

  def show
    @tweet = Feed::Tweet.find(params[:id]).decorate
    render layout: false
  end

  # User submit tweet
  def create
    form = TweetForm.from_params(current_user, params)

    if form.valid?
      service = TweetService::Create.new(current_user, form.tweet)
      service.perform
      render partial: "components/feed",
        object: service.feed.decorate, as: :feed,
        layout: false
    else
      puts form.errors.full_messages
      head :bad_request
    end
  end

  def update

  end

  def destroy
    tweet = Feed::Tweet.find_by(id: params[:id], user: current_user)
    if tweet
      TweetService::Destroy.new(tweet).perform
      head :ok
    else
      head :bad_request
    end
  end
end
