module Replies::ReactsController
  # TODO: Refactoring
  POLYMORPHIC_REACT = {
    like: :likable,
    retweet: :retweetable
  }

  def index

  end

  def create
    reply = Tweet::Reply.find(params[:id])
    react = react_class.find_by(user: current_user, "#{react_polymorphic_name}": reply)

    if react
      head :bad_request
    else
      service_class.new(reply, current_user).perform
      render(
        json: {
          count: reply.send(controller_name).count,
          message: :destroyed
        },
        status: :ok
      )
    end
  end

  def destroy
    reply = Tweet::Reply.find(params[:id])
    service_class.new(reply, current_user).perform
    render(
      json: {
        count: reply.send(controller_name).count,
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
    "reply_service/react/#{react_name}/#{action_name}".camelize.constantize
  end
end
