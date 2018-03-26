module Replies::ReactsController
  # TODO: Refactoring
  def index

  end

  def create
    reply = Tweet::Reply.find(params[:id])
    react = react_class.find_by(user: current_user, reply: reply)

    if react
      head :bad_request
    else
      service_class.new(reply, current_user).perform
      head :ok
    end
  end

  def destroy
    reply = Tweet::Reply.find(params[:id])
    service_class.new(reply, current_user).perform
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
    "reply_service/react/#{react_name}/#{action_name}".camelize.constantize
  end
end
