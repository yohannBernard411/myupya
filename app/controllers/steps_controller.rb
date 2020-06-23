class StepsController < ApplicationController

  def index
    @steps = Step.all
    @articles = Article.all
    @videos = Video.all
    @coachs = Coach.all
  end
  
end
