class ApplicationController < ActionController::Base
  before_action :load_topics
  before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def load_topics
    @topics = Topic.desc(:questions_count).limit(5)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :title])
  end

end
