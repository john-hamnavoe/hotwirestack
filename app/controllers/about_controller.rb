class AboutController < ApplicationController
  def index
    @user = Current.user
    @index_views = @user.index_views
  end
end
