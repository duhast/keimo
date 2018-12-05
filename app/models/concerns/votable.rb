module Concerns
  module Votable
    extend ActiveSupport::Concern

    included do
      field :voters, type: Array, default: []
    end

    def vote_from(voting_user)
      return false if self.voters.include?(voting_user.id)
      self.voters.push(voting_user.id)
      true
    end


  end
end
