class CoachsController < ApplicationController
  def show
    @coach = Coach.find(params[:id])
  end
end
