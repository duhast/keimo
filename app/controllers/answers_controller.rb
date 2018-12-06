class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :set_answer, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    if @answer.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      redirect_to @question, alert: @answer.errors.full_messages.first
    end
  end

  def update
    if @question.update(question_params)
      redirect_to question_url(@question), notice: 'Answer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_url(@question), notice: 'Answer was successfully destroyed.'
  end

private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:text)
  end
end
