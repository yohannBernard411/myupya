class StepsController < ApplicationController

  def index
    cookies[:currentstep] = (Step.find(current_user.step_id).position).to_s || 'none'
    @steps = Step.all
    @articles = Article.all
    @videos = Video.all
    @coachs = Coach.all
    @stepurl = ["https://images.unsplash.com/photo-1573497491208-6b1acb260507?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                "https://images.unsplash.com/photo-1491308056676-205b7c9a7dc1?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                "https://images.unsplash.com/photo-1586281380349-632531db7ed4?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                "https://images.unsplash.com/photo-1565689157206-0fddef7589a2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                "https://images.unsplash.com/photo-1521791055366-0d553872125f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                "https://images.unsplash.com/photo-1552664730-d307ca884978?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9"]
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
