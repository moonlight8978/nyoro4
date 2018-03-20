class Feeds::TweetsController < ApplicationController
  def show
    tweet = Feed::Tweet.find(params[:id]).decorate
    render partial: "components/tweet/full", object: tweet, as: :tweet, layout: false
  end

  # User submit tweet
  def create
    form = TweetForm.from_params(current_user, params)

    if form.valid?
      TweetService::Create.new(current_user, form.tweet).perform
      head :ok
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
