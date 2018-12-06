class UsersController < ApplicationController
  include Concerns::HasFollow

  before_action :authenticate_user!
  before_action :set_user

protected

  def set_user
    @user = User.find(params[:user_id])
  end

  def follow_subject
    @user
  end

end
