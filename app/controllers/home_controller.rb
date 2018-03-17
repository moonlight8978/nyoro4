class HomeController < ApplicationController
  layout :determine_layout
  
  decorates_assigned :user

  def index
    @user = current_user
  end

private

  def determine_layout
    user_signed_in? ? "application" : "full_page"
  end
end
