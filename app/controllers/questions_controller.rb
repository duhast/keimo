class QuestionsController < ApplicationController
  include Concerns::HasFollow

  before_action :authenticate_user!, only: [:new, :edit, :create, :delete]
  before_action :set_question, except: [:new, :index]

  def index
    if params[:topic_id].present?
      @topic = Topic.find(params[:topic_id])
      @questions = @topic.questions
    else
      @questions = Question.all
    end
  end

  def show
    @answers = @question.answers.desc(:created_at)
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))
    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.user != current_user
      @question.errors.add(:base, 'Question created by another user')
      render :edit
    elsif @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @question.user == current_user && @question.destroy
      redirect_to questions_url, notice: 'Question was successfully destroyed.'
    else
      redirect_to questions_url, alert: 'Cannot delete this question.'
    end
  end

protected
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:text, :anonymous, :topic_id)
  end

  def follow_subject
    @question
  end

end
