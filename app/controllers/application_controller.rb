class ApplicationController < ActionController::Base
  before_action :load_topics


protected

  def load_topics
    @topics = Topic.desc(:questions_count).limit(5)
  end

end
