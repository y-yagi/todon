class IndexController < ApplicationController
  def index
    redirect_to todos_url if logged_in?
  end
end
