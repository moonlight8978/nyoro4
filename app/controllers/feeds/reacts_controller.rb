module Feeds::ReactsController
  # TODO: #index get everyone reacted to tweet
  def index

  end

  def create
    tweet = Feed::Tweet.find(params[:id])
    react = react_class.find_by(user: current_user, tweet: tweet)

    if react
      head :bad_request
    else
      service_class.new(tweet, current_user).perform
      head :ok
    end
  end

  def destroy
    tweet = Feed::Tweet.find(params[:id])
    service_class.new(tweet, current_user).perform
    head :ok
  end

protected

  def react_name
    controller_name.singularize
  end

  def react_class
    "feed/#{controller_name.singularize}".camelize.constantize
  end

  def service_class
    "react_service/#{react_name}/#{action_name}".camelize.constantize
  end
end
