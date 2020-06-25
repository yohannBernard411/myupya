class StepsController < ApplicationController

  def index
    @steps = Step.all
    @articles = Article.all
    @videos = Video.all
    @coachs = Coach.all
    @current_step = Step.find(current_user.step_id).position
  end
  
end
