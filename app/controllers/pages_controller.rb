class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :show ]
  layout "layout_home", only: :home

  def home

  end

  def show

  end
end
