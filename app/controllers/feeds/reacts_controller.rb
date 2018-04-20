module Feeds::ReactsController
  # TODO: #index get everyone reacted to tweet
  POLYMORPHIC_REACT = {
    like: :likable,
    retweet: :retweetable
  }

  def index

  end

  def create
    tweet = Feed::Tweet.find(params[:id])
    react = react_class.find_by(user: current_user, "#{react_polymorphic_name}": tweet)

    if react
      head :bad_request
    else
      service_class.new(tweet, current_user).perform
      render(
        json: {
          count: tweet.send(controller_name).count,
          message: :destroyed
        },
        status: :ok
      )
    end
  end

  def destroy
    tweet = Feed::Tweet.find(params[:id])
    service_class.new(tweet, current_user).perform
    render(
      json: {
        count: tweet.send(controller_name).count,
        message: :destroyed
      },
      status: :ok
    )
  end

protected

  def react_polymorphic_name
    POLYMORPHIC_REACT[react_name.to_sym]
  end

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
