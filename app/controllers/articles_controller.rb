class ArticlesController < ApplicationController
  def show
    cookies[:currentstep] = (Step.find(current_user.step_id).position).to_s || 'none'
    @article = Article.find(params[:id])
  end
end
