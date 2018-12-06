module Concerns
  module HasFollow
    extend ActiveSupport::Concern

    def follow
      if follow_subject.follow_by(current_user)
        follow_subject.save
        flash[:notice] = 'Now you are a follower!'
      end
      redirect_back(fallback_location: root_path)
    end

  end
end
