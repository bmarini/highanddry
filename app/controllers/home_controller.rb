class HomeController < ApplicationController
  def index
  end

  def facebook_channel
    expires_in 1.year, :public => true
    render :layout => false
  end
end
