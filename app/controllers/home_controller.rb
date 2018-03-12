class HomeController < ApplicationController
  layout :determine_layout

  def index
    if user_signed_in?
      @suggestions = User.suggestions_for(current_user)
    end
  end

private

  def determine_layout
    user_signed_in? ? "application" : "full_page"
  end
end
