class AnswersController < ApplicationController
  def create
    render 'questions/show' if answer_params[:choices].blank?

    choice = Choice.find(answer_params[:choices])

    answer = Answer.new(
      user: current_user,
      choice: choice
    )

    current_user.update(
      current_question_id: choice.next_question_id,
      step_id: choice.step_id
    )

    answer.save

    if choice.question_id == Question.last.id && choice.value == true
      # ajouter une modal
    elsif choice.next_question_id.nil?
      redirect_to steps_path
    else
      redirect_to question_path(choice.next_question_id)
    end
  end

  private

  def answer_params
    params.require(:question).permit(:choices)
  end
end
