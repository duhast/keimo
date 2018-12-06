class HomeController < ApplicationController
  QUESTION_LIMIT = 20

  def feed
    if user_signed_in?
      followed_user_ids = User.where(followers: current_user.id).pluck(:id)
      @followed_users_questions = Question.where(:user.in => followed_user_ids).desc(:answers_count).limit(QUESTION_LIMIT)
      @followed_questions = Question.where(followers: current_user.id).desc(:answers_count).limit(QUESTION_LIMIT)
    end
    @questions = Question.desc(:answers_count).limit(QUESTION_LIMIT)
  end

end
