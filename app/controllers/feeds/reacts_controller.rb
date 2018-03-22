module Feeds::ReactsController
  extend ActiveSupport::Concern

  included do
    def index

    end

    def create
      tweet = Feed::Tweet.find(params[:id])
      react = react_class.find_by(user: current_user, tweet: tweet)

      if react
        head :bad_request
      else
        self.react = react_class.create(user: current_user, tweet: tweet)
        self.react.create_feed
        head :ok
      end
    end

    def destroy
      tweet = Feed::Tweet.find(params[:id])
      react_class
        .find_by(user: current_user, tweet: tweet)
        .destroy
      head :ok
    end

  protected

    def react_name
      controller_name.singularize
    end

    def react_class
      "feed/#{controller_name.singularize}".camelize.constantize
    end

    def react
      instance_variable_get(:"@#{react_name}")
    end

    def react=(react)
      instance_variable_set(:"@#{react_name}", react)
    end

    def service_class
      "react_service/#{react_name}/#{action_name}".camelize.constantize
    end
  end
end
