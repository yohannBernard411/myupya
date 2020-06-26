class StepsController < ApplicationController

  def index
    @steps = Step.all
    @articles = Article.all
    @videos = Video.all
    @coachs = Coach.all
    @current_step = Step.find(current_user.step_id).position
  end

  def up
    @question = Question.find(current_user.current_question_id)
    @choice = Choice.where(question_id: @question.id)
    if @choice[0].next_question_id
      @next_question = Question.find(@choice[0].next_question_id)
      @next_step = Step.find(@choice[0].step_id)
      current_user.update(
        current_question_id: @next_question.id,
        step_id: @next_step.id
      )
      redirect_to question_path(current_user.current_question_id)
    else
      redirect_to pages_show_path
    end
  end
  
end
