module Concerns
  module Followable
    extend ActiveSupport::Concern

    included do
      field :followers, type: Array, default: []
    end

    def follow_by(following_user)
      return false if self.followers.include?(following_user.id) || self.followers.include?(self.id)
      self.followers.push(following_user.id)
      true
    end


  end
end
