class AnswersController < ApplicationController
  def create

    render 'questions/show' if answer_params[:choices].blank?

    choice = Choice.find(answer_params[:choices])
    redirect_to steps_path if choice.value == false

    answer = Answer.new(
      user: current_user,
      choice: choice
    )
    if answer.save && choice.value == true
      current_user.update(
      current_question_id: choice.next_question_id,
      step_id: choice.step_id
      )

      redirect_to question_path(choice.next_question_id)
    end
  end

  private

  def answer_params
    params.require(:question).permit(:choices)
  end
end
