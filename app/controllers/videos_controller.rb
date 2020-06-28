class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    index = Video.all.index(@video)
    @step = Step.all[index]
  end
end
