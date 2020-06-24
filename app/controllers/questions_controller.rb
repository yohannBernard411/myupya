class QuestionsController < ApplicationController

  def show
    @question = Question.new
    if current_user.current_question_id
      @question = Question.find(current_user.current_question_id)
    else
      @question = Question.first
    end
    render 'show'
  end

  def method_name

  end

end
